#import <Preferences/Preferences.h>
#import <CoreFoundation/CoreFoundation.h>

extern void OperatorChanged(void *observer, CFStringRef fakeOperator, CFStringRef defaultOperator);

@interface FakeOperatorPreferencesListController: PSListController {
}

- (void)setPreferenceValue:(id)value specifier:(id)specifier;
@end

@implementation FakeOperatorPreferencesListController

- (void)setPreferenceValue:(id)value specifier:(id)specifier {
	
	[super setPreferenceValue:value specifier:specifier];
}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPreferences" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
