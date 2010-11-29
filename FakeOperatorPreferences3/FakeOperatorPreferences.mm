#import <Preferences/Preferences.h>

@interface FakeOperatorPreferencesListController: PSListController { }
@end

@implementation FakeOperatorPreferencesListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPreferences" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
