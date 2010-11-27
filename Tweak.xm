/***
 * Fake Operator
 * Thanks to DarkMalloc
 * NSPwn (c) 2010
 **/

%hook SBTelephonyManager

- (void)setOperatorName:(id)arg1 {
	
	NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperator.plist";
	NSString *replacement;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
	
		NSDictionary *fakeCarrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		
		if ([fakeCarrier objectForKey:@"Enabled"]) {
			
			replacement = [[fakeCarrier objectForKey:@"FakeOperator"] retain];
			
			NSLog(@"com.nspwn.fakeoperator is enabled, overriding carrier %@ with %@.", arg1, replacement);
			
			// Lets write the plist (with the original value of arg1) we can revert to this value if we disable it in Settings.app
			NSMutableDictionary *out = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
			[out setValue:arg1 forKey:@"DefaultOperator"];
			[out writeToFile:settingsFile atomically: YES];
			[out release];
			
			%orig(replacement);
		} else if (arg1 == @"FakeOperator-DEFAULT") {
		
			//Settings.app is asking us to reset the value to the Default Operator!
			replacement = [[fakeCarrier objectForKey:@"DefaultOperator"] retain];
			
			NSMutableDictionary *out = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
			[out setValue:NO forKey:@"Enabled"];
			[out writeToFile:settingsFile atomically: YES];
			[out release];
		}
		
		[fakeCarrier release];
	}
	
	[settingsFile release];
	
	if (!replacement || [arg1 isEqualToString:replacement]) {
	
		%orig(arg1);
	} else {
	
		%orig(replacement);
	}
}

%end