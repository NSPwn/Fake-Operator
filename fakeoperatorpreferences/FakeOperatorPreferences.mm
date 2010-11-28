#import <Preferences/Preferences.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>

static CFNotificationCenterRef darwinNotifyCenter = CFNotificationCenterGetDarwinNotifyCenter();

@interface FakeOperatorPreferencesListController: PSListController {
}

- (void)setPreferenceValue:(id)value specifier:(id)specifier;
@end

@implementation FakeOperatorPreferencesListController

- (void)setPreferenceValue:(id)value specifier:(id)specifier {
	[super setPreferenceValue:value specifier:specifier];
	// Post a notification.
	NSString *notification = [specifier propertyForKey:@"postNotification"];
	CFNotificationCenterPostNotification(darwinNotifyCenter, (CFStringRef)notification, NULL, NULL, true);
}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPreferences" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
