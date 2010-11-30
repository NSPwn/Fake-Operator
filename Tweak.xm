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
	char serviceImageBlack[100];
	char serviceImageSilver[100];
	char operatorDirectory[1024];
	unsigned int serviceContentType;
	int wifiSignalStrengthRaw;
	int wifiSignalStrengthBars;
	unsigned int dataNetworkType;
	int batteryCapacity;
	unsigned int batteryState;
	char notChargingString[150];
	int bluetoothBatteryCapacity;
	int thermalColor;
	unsigned int slowActivity:1;
	char activityDisplayId[256];
	unsigned int bluetoothConnected:1;
	char recordingAppString[100];
	unsigned int displayRawGSMSignal:1;
	unsigned int displayRawWifiSignal:1;
} _data;

@class CPDistributedMessagingCenter;

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperatorpreferences.plist";

%class SBStatusBarDataManager

static void reloadPrefsNotification(CFNotificationCenterRef center,
					void *observer,
					CFStringRef name,
					const void *object,
					CFDictionaryRef userInfo) {
	NSLog(@"com.nspwn.fakeoperator Operator changed");
	NSDictionary *carrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
	
	id dataManager = [%c(SBStatusBarDataManager) sharedDataManager];
	
	[dataManager _updateServiceItem];
	
	[dataManager _dataChanged];
	
	[carrier release];
}

%hook SBStatusBarDataManager

- (void)_updateServiceItem {
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		
		NSDictionary *carrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		
		if ([[carrier objectForKey:@"Enabled"] boolValue] && [carrier objectForKey:@"FakeCarrier"] != nil) {
			
			_data &data(MSHookIvar<_data>(self , "_data"));
			
			strncpy(data.serviceString, [[carrier objectForKey:@"FakeCarrier"] UTF8String], 100);
			data.serviceString[99] = '\0';
			
		} else {
			
			NSString *&serviceString(MSHookIvar<NSString *>(self , "_serviceString"));
			
			_data &data(MSHookIvar<_data>(self , "_data"));
			
			strncpy(data.serviceString, [serviceString UTF8String], 100);
			data.serviceString[99] = '\0';
			
		}
		
		
		[carrier release];
		
	}
	
	
	%orig;
}

%end

%ctor {
	%init;
	CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(r, NULL, &reloadPrefsNotification,
		CFSTR("com.nspwn.fakeoperator/operatorChanged"), NULL, 0);
}
