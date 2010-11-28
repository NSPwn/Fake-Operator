#import <Preferences/Preferences.h>

@interface FakeOperatorPreferencesListController: PSListController {
}

- (void)setPreferenceValue:(id)value specifier:(id)specifier;
@end

@implementation FakeOperatorPreferencesListController

- (void)setPreferenceValue:(id)value specifier:(id)specifier {
	
	[super setPreferenceValue:value specifier:specifier];
	// Post a notification.
	CPDistributedMessagingCenter *messagingCenter;
	messagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"com.nspwn.fakeoperator"];
	[messagingCenter sendMessageName:@"operatorChanged" userInfo:nil];
	[messagingCenter release];
}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPreferences" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
