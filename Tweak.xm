/***
 * FakeOperator
 * Thanks to DarkMalloc
 * NSPwn (c) 2010
 **/

%hook SBTelephonyManager

- (void)setOperatorName:(id)arg1 {
	
	NSString *settingsFile = @"/var/mobile/Library/Preferences/com.nspwn.fakeoperator.plist";
	NSString *replacement = [NSString stringWithString:arg1];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
	
		NSDictionary *fakeCarrier = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		
		if ([fakeCarrier objectForKey:@"Enabled"]) {
			
			[replacement release];
			replacement = [[fakeCarrier objectForKey:@"FakeOperator"] retain];
			
			NSLog(@"com.nspwn.fakeoperator is enabled, overriding carrier %@ with %@.", arg1, replacement);
			
			// Lets write the plist (with the original value of arg1) we can revert to this value if we disable it in Settings.app
			NSMutableDictionary *out = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
			[out setValue:arg1 forKey:@"DefaultOperator"];
			[out writeToFile:settingsFile atomically: YES];
			[out release];
			
			%orig(replacement);
			return;
		} else if (arg1 == @"FakeOperator-DEFAULT") {
		
			//Settings.app is asking us to reset the value to the Default Operator!
			[replacement release];
			replacement = [[fakeCarrier objectForKey:@"DefaultOperator"] retain];
			return;
		}
		
		[fakeCarrier release];
	}
	
	[settingsFile release];
	
	%orig(replacement);
}

%end