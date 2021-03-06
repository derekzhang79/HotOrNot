//
//  HONFacebookSwitchView.m
//  HotOrNot
//
//  Created by Matthew Holcombe on 12.16.12.
//  Copyright (c) 2012 Built in Menlo, LLC. All rights reserved.
//

#import "HONFacebookSwitchView.h"
#import "HONAppDelegate.h"

@implementation HONFacebookSwitchView

@synthesize switchButton = _switchButton;

- (id)init {
	if ((self = [super initWithFrame:CGRectMake(5.0, 25.0, 59.0, 34.0)])) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_updateFBPosting:) name:@"UPDATE_FB_POSTING" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_fbSwitchHidden:) name:@"FB_SWITCH_HIDDEN" object:nil];
		
		_switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_switchButton.frame = CGRectMake(0.0, 0.0, 59.0, 34.0);
		[_switchButton setBackgroundImage:[UIImage imageNamed:@"facebookToggle_off"] forState:UIControlStateNormal];
		[_switchButton setBackgroundImage:[UIImage imageNamed:@"facebookToggle_on"] forState:UIControlStateSelected];
		[_switchButton addTarget:self action:@selector(_goToggle) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_switchButton];
		
		[self _updateSwitch];
	}
	return (self);
}


#pragma mark - Navigation
- (void)_goToggle {
	BOOL canPost = [HONAppDelegate allowsFBPosting];
	
	[HONAppDelegate setAllowsFBPosting:!canPost];
	[self _updateSwitch];
}

#pragma mark - Notifications
- (void)_updateFBPosting:(NSNotification *)notification {
	[self _updateSwitch];
}

- (void)_fbSwitchHidden:(NSNotification *)notification {
	_switchButton.hidden = [(NSString *)[notification object] isEqualToString:@"Y"];
	[self _updateSwitch];
}


- (void)_updateSwitch {
	NSLog(@"FB POSTING:[%d]", [HONAppDelegate allowsFBPosting]);
	[_switchButton setSelected:[HONAppDelegate allowsFBPosting]];
}

@end
