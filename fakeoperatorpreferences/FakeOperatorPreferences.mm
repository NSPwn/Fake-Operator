#import <Preferences/Preferences.h>
#import "AppSupport/CPDistributedMessagingCenter.h"

@interface FakeOperatorPreferencesListController: PSListController {
}

- (void)setPreferenceValue:(id)value specifier:(id)specifier;
@end

@implementation FakeOperatorPreferencesListController

- (void)setPreferenceValue:(id)value specifier:(id)specifier {
	
	[super setPreferenceValue:value specifier:specifier];
	
	//Grab unique messaging center
	CPDistributedMessagingCenter *messagingCenter;
	messagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"com.nspwn.fakeoperator"];
	
	//Send message
	[messagingCenter sendMessageName:@"operatorChanged" userInfo:nil];
}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPreferences" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
