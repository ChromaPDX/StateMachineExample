//
//  HelloWorldLayer.m
//  StateMachineExample
//
//  Created by David Hart on 2010/11/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		
		// Schedule a state machine update loop
		sm = [[StateMachine alloc] init:self];
		sm.debug = YES;
		[sm SwitchState:@"Tick"];
		[self schedule:@selector(Update:)];
	}
	return self;
}

- (void) Update:(ccTime)dt
{
	[sm Update:dt];
}

- (void) Tick__Enter { NSLog(@"YES : Tick Enter"); }
- (void) Tick__Update:(float) dt {
	NSLog(@"YES : Tick Update"); 
	if (sm.stateTime > 1.0f) [sm SwitchState:@"Tock"];
}
- (void) Tick__Exit { NSLog(@"YES : Tick Exit"); }

- (void) Tock__Enter { NSLog(@"YES : Tock Enter"); }
- (void) Tock__Update:(float) dt { 
	NSLog(@"YES : Tock Update"); 
	if (sm.stateTime > 1.0f) [sm SwitchState:@"Tick"];
}
- (void) Tock__Exit { NSLog(@"YES : Tock Exit"); }


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
