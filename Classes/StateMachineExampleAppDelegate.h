//
//  StateMachineExampleAppDelegate.h
//  StateMachineExample
//
//  Created by David Hart on 2010/11/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface StateMachineExampleAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
