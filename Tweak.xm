/***
 * Fake Operator
 * Thanks to DarkMalloc
 * NSPwn (c) 2010
 **/

%hook SBTelephonyManager

- (void)setOperatorName:(id)arg1 {

	NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperatorpreferences.plist";
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
}

%end

static void operatorChangedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	//CDUpdatePrefs();
	NSLog(@"Operator Changed Notification Received");
}

static _Constructor void FakeOperatorInitialize() {

	%init;
	CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(r, NULL, &reloadPrefsNotification, CFSTR("com.nspwn.fakeoperator/operatorChanged"), NULL, 0);
}