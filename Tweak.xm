/***
 * Fake Operator
 * Thanks to DarkMalloc
 * iPod-Compatiblility by Frigid
 * NSPwn (c) 2010
 **/
#import "AppSupport/CPDistributedMessagingCenter.h"

#include <stdio.h>
#include <string.h>

typedef struct {
	char itemIsEnabled[22];
	char timeString[64];
	int gsmSignalStrengthRaw;
	int gsmSignalStrengthBars;
	char serviceString[100];
} _42data;

typedef struct {
	char itemIsEnabled[20];
	char timeString[64];
	int gsmSignalStrengthRaw;
	int gsmSignalStrengthBars;
	char serviceString[100];
} _41data;

@class CPDistributedMessagingCenter;

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperatorpreferences.plist";
float _FOfirmwareVersion = 0.0f;
NSDictionary *_FOcarrier;

%class SBStatusBarDataManager

static void reloadPrefsNotification(CFNotificationCenterRef center,
					void *observer,
					CFStringRef name,
					const void *object,
					CFDictionaryRef userInfo) {
	NSLog(@"com.nspwn.fakeoperator Operator changed");
	_FOcarrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
	
	id dataManager = [%c(SBStatusBarDataManager) sharedDataManager];
	
	[dataManager _updateServiceItem];
	
	[dataManager _dataChanged];
}


%hook SBStatusBarDataManager

- (void)_updateServiceItem {
	
	if (_FOcarrier != NULL) {
			
		NSLog(@"%@", _FOcarrier);
		
		NSLog(@"Firmware: %f", _FOfirmwareVersion);
		
			if ([[_FOcarrier objectForKey:@"Enabled"] boolValue] && [_FOcarrier objectForKey:@"FakeCarrier"] != nil) {
				
				if (_FOfirmwareVersion == 4.2) {
					
					_42data &data(MSHookIvar<_42data>(self , "_data"));
					
					strncpy(data.serviceString, [[_FOcarrier objectForKey:@"FakeCarrier"] UTF8String], 100);
					data.serviceString[99] = '\0';
					
				} else if (_FOfirmwareVersion == 4.1 || _FOfirmwareVersion == 4.0) {
					
					_41data &data(MSHookIvar<_41data>(self , "_data"));
					
					strncpy(data.serviceString, [[_FOcarrier objectForKey:@"FakeCarrier"] UTF8String], 100);
					data.serviceString[99] = '\0';
					
				}
				
			} else {
				
				if (_FOfirmwareVersion == 4.2) {
					
					_42data &data(MSHookIvar<_42data>(self , "_data"));
					
					NSString *&serviceString(MSHookIvar<NSString *>(self , "_serviceString"));
					
					if (serviceString != NULL) {
						strncpy(data.serviceString, [serviceString UTF8String], 100);
						data.serviceString[99] = '\0';
					}
					
				} else if (_FOfirmwareVersion = 4.1 || _FOfirmwareVersion == 4.0) {
					
					_41data &data(MSHookIvar<_41data>(self , "_data"));
					
					NSString *&serviceString(MSHookIvar<NSString *>(self , "_serviceString"));
					
					if (serviceString != NULL) {
						strncpy(data.serviceString, [serviceString UTF8String], 100);
						data.serviceString[99] = '\0';
					}
					
				}
				
			}
		
	}
	
	%orig;
}

%end

%ctor {
	if (kCFCoreFoundationVersionNumber == 550.52) { _FOfirmwareVersion = 4.2f; }
	if (kCFCoreFoundationVersionNumber == 550.38) { _FOfirmwareVersion = 4.1f; }
	if (kCFCoreFoundationVersionNumber == 550.32) { _FOfirmwareVersion = 4.0f; }
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) { 
		_FOcarrier = [NSDictionary dictionaryWithContentsOfFile:settingsFile];
	}
	%init;
	CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(r, NULL, &reloadPrefsNotification,
		CFSTR("com.nspwn.fakeoperator/operatorChanged"), NULL, 0);
}
