#import <Preferences/Preferences.h>
#import <SpringBoard/SpringBoard.h>

@interface FakeOperatorPrefsListController: PSListController {
	UITextField * opField;
}
@end

@implementation FakeOperatorPrefsListController

- (void)changeTo:(id)item {
	
	NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperator.plist";
	NSMutableDictionary *out = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
	[out setValue:item forKey:@"FakeOperator"];
	[out writeToFile:settingsFile atomically: YES];
	[out release];
	
	CPDistributedMessagingCenter *messagingCenter;
 	// Center name must be unique, recommend using application identifier.
	messagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"com.nspwn.fakeoperator"];
	
	[messagingCenter sendMessageName:@"operatorChanged" userInfo:nil];
	
}

- (void)default:(id)item {
	
	[self changeTo:@"FakeOperator-DEFAULT"];
}

- (void)changeOperatorName:(id)item {
	
	UIAlertView *dialog = [[UIAlertView alloc] init];
	[dialog setDelegate:self];
	[dialog setTitle:@"Enter Operator Name"];
	[dialog setMessage:@"\n"];
	[dialog addButtonWithTitle:@"Cancel"];
	[dialog addButtonWithTitle:@"Change"];
	opField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
	[opField setBackgroundColor:[UIColor whiteColor]];
	[opField setPlaceholder:@"Operator name"];
	[dialog addSubview:opField];
	[dialog show];
	[opField becomeFirstResponder];
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex { 
	
	NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperator.plist";
    NSLog(@"%d", (int) buttonIndex);

    if (buttonIndex == 1) { 
		[self changeTo:[opField text]];
	} else {
	}
}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
