/***
 * Fake Operator
 * Thanks to DarkMalloc
 * NSPwn (c) 2010
 **/
#import "AppSupport/CPDistributedMessagingCenter.h"

@class CPDistributedMessagingCenter;

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperatorpreferences.plist";

%class SBTelephonyManager

static void reloadPrefsNotification(CFNotificationCenterRef center,
					void *observer,
					CFStringRef name,
					const void *object,
					CFDictionaryRef userInfo) {
	NSLog(@"com.nspwn.fakeoperator Operator changed");
	NSDictionary *carrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];

	id controller = [%c(SBTelephonyManager) sharedTelephonyManager];
	[controller setOperatorName:[carrier objectForKey:@"DefaultCarrier"]];
	[carrier release];
}

%hook SBTelephonyManager

- (void)setOperatorName:(id)arg1 {

	if (arg1 != nil) {
	
		NSString *replacement = [[NSString alloc] initWithString:arg1];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		
			NSDictionary *carrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
			NSLog(@"Carrier: %@", carrier);
			
			if ([[carrier objectForKey:@"Enabled"] boolValue]) {
				
				NSLog(@"com.nspwn.fakeoperator is enabled");
				NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
				
				if ([[carrier objectForKey:@"FakeCarrier"] isEqualToString:@""]) {
				
					//Resetting Carrier / Disable
					[replacement release];
					replacement = [carrier objectForKey:@"DefaultCarrier"];
					[plist setObject:[NSNumber numberWithBool:NO] forKey:@"Enabled"];
				} else {
			
					//Enable & Set DefaultCarrier (Backup)
					[plist setObject:[NSNumber numberWithBool:YES] forKey:@"Enabled"];
					[plist setObject:arg1 forKey:@"DefaultCarrier"];
					[replacement release];
					replacement = [carrier objectForKey:@"FakeCarrier"];
				}
				
				[plist writeToFile:settingsFile atomically:YES];
				[plist release];
		} else {
			
			NSLog(@"com.nspwn.fakeoperator is disabled");
		}
		
		[carrier release];
	}
	
	[settingsFile release];
	
	NSLog(@"com.nspwn.fakeoperator: %@", replacement);

	%orig(replacement);
	
	} else {
	
		%orig;
	}
}

%end

%ctor {
	%init;
	CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(r, NULL, &reloadPrefsNotification,
		CFSTR("com.nspwn.fakeoperator/operatorChanged"), NULL, 0);
}
