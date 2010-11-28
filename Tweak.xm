/***
 * Fake Operator
 * Thanks to DarkMalloc
 * NSPwn (c) 2010
 **/

#import "AppSupport/CPDistributedMessagingCenter.h"

@class CPDistributedMessagingCenter;

static CPDistributedMessagingCenter *MainMessagingCenter;

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperator.plist";
static NSDictionary *carrier;

%hook SBTelephonyManager

- (id)init {

	// Center name must be unique, recommend using application identifier.
	MainMessagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"com.nspwn.fakeoperator"];
	[MainMessagingCenter runServerOnCurrentThread];

	// Register Messages
	[MainMessagingCenter registerForMessageName:@"operatorChanged" target:self selector:@selector(operatorChanged)];

	%orig;

}

%new
- (void)operatorChanged {
	carrier = [NSDictionary dictionaryWithContentsOfFile:settingsFile];
	NSString *carrierString = [carrier objectForKey:@"FakeOperator"];
	id controller = [NSClassFromString(@"SBTelephonyManager") sharedTelephonyManager];
	[controller setOperatorName:[carrier objectForKey:@"FakeOperator"]];
}

- (void)setOperatorName:(id)arg1 {
	
	NSString *replacement;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
	
		carrier = [NSDictionary dictionaryWithContentsOfFile:settingsFile];
		
		if ([[carrier objectForKey:@"Enabled"] boolValue] || [arg1 isEqualToString:@"FakeOperator-DEFAULT"]) {
		
			if ([arg1 isEqualToString:@"FakeOperator-DEFAULT"]) {
				
				NSLog(@"com.nspwn.fakeoperator Reset triggered, disabling");
				//Settings.app is resetting the value!
				replacement = [carrier objectForKey:@"DefaultOperator"];
				NSMutableDictionary *out = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
				[out setValue:[0 integerValue] forKey:@"Enabled"];
				[out writeToFile:settingsFile atomically: YES];
				[out release];
			} else {
			
				replacement = [carrier objectForKey:@"FakeOperator"];
			
				NSLog(@"com.nspwn.fakeoperator is enabled, overriding carrier %@ with %@.", arg1, replacement);
			
				// Lets write the plist (with the original value of arg1) we can revert to this value if we disable it in Settings.app
				NSMutableDictionary *out = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
				[out setValue:arg1 forKey:@"DefaultOperator"];
				[out setObject:[NSNumber numberWithBool:YES] forKey:@"Launched"];
				[out writeToFile:settingsFile atomically: YES];
				[out release];
			}
			
		}
	}
	
	[settingsFile release];
	
	if (!replacement || [arg1 isEqualToString:replacement]) {
	
		%orig(arg1);
	} else {
	
		%orig(replacement);
	}
}

%end