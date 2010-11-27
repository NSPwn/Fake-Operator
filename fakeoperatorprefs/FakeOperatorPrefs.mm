#import <Preferences/Preferences.h>

@interface FakeOperatorPrefsListController: PSListController {
	UITextField * opField;
}
@end

@implementation FakeOperatorPrefsListController

- (void)default:(id)item {
	
}

- (void)changeOperatorName:(id)item {
	UIAlertView *dialog = [[UIAlertView alloc] init];
	[dialog setDelegate:self];
	[dialog setTitle:@"Enter Operator Name"];
	[dialog setMessage:@"\n"];
	[dialog addButtonWithTitle:@"Cancel"];
	[dialog addButtonWithTitle:@"Change"];
	opField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
	[opField setBackgroundColor:[UIColor whiteColor]];
	[opField setPlaceholder:@"Operator name"];
	[dialog addSubview:opField];
	[dialog show];
	[dialog becomeFirstResponder];

}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{    
        NSLog(@"%d", (int) buttonIndex);
        if (buttonIndex == 1) { // Change pushed
			NSLog(@"Op name: %@", [opField text]);
			// Need to figure out a good way to communicate with our dylib (NSNotificationCenter?)
        } else {
		}
}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FakeOperatorPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
