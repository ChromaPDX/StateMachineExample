//
//  HelloWorldLayer.h
//  StateMachineExample
//
//  Created by David Hart on 2010/11/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "StateMachine.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
	StateMachine* sm;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
