#import <Preferences/Preferences.h>

@interface FakeOperatorPrefsListController: PSListController {
}
@end

@implementation FakeOperatorPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
