//
//  StateMachine.m
//
//  Created by David Hart on 2010/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StateMachine.h"


// State Machine.
//
// You can use these functions as an easy way to set up a state machine.  
// Using the state machine ensures that elements that are started in
// a state are always properly cleaned up by guaranteeing that a state
// Enter/Exit is always called on a state change.  This dramatically simplifies
// many common operations and more importantly ensures proper
// operation and stability.
//
// Each state must have three functions:
//
// an Enter (called when the state has been switched to),
// 
// an Exit (called when the state has been switched from), and
// 
// an Update (called every frame* while the state is active).
//
// Use SwitchState() to switch states.  The parameter is the base name of the
// state.  For example, if I had a state I wanted to call "Proximity", I would
// need to define "Proximity__Enter", "Proximity__Exit" and
// "Proximity__Update:dt".  
// Then I could call [StateMachine SwitchState:@"Proximity"] to
// switch to this new state.
// 
// properties: 
//
// curState holds the base name of the current state.
//
// stateTime is the seconds elapsed since the state was switched to.
//
//............................................................................

@implementation StateMachine

@synthesize stateTime;
@synthesize nextState;
@synthesize curState;
@synthesize debug;

// on "init" you need to initialize your instance
-(id) init: (id) parentClass
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) 
	{
		parent = parentClass;
		nextState = nil;
		curState = nil;
		stateTime = 0;
		debug = false;
	}
	return self;
}

- (void) Debug: (NSString*) stateName
{
	if ( debug ) 
	{
		NSLog( @"%@", stateName );
	}
}

- (void) SwitchState: (NSString*) newState
{
	nextState = newState;
}

- (void) Update: (float) dt
{ 
	if ( [nextState compare:@""] != NSOrderedSame )
	{
		// call the current state exit function.
		if ( [curState compare:@""] != NSOrderedSame )
		{
			NSString* exitSelName = [NSString stringWithFormat:@"%@__Exit", curState];
			[self Debug:exitSelName];
			SEL exitSel = NSSelectorFromString(exitSelName);
			if ([parent respondsToSelector:exitSel])
			{
				objc_msgSend(parent, exitSel);
			}
		}
		
		// clear the state time and reset the start time, since we're going 
		// into a new one.
		stateTime = 0;

		// call the new state enter function.
		NSString* enterSelName = [NSString stringWithFormat:@"%@__Enter", nextState];
		[self Debug:enterSelName];
		SEL enterSel = NSSelectorFromString(enterSelName);
		if ([parent respondsToSelector:enterSel])
		{
			objc_msgSend(parent, enterSel);
		}
		
		// update the state machine.
		curState = nextState;
		nextState = nil;
	}
	
	if ( [curState compare:@""] != NSOrderedSame )
	{
		// call the current state update function.
		NSString* updateSelName = [NSString stringWithFormat:@"%@__Update:", curState];
		[self Debug:updateSelName];
		SEL updateSel = NSSelectorFromString(updateSelName);
		if ([parent respondsToSelector:updateSel])
		{
            //void (*objc_msgSendUpdate)(id self, SEL _cmd, float dt) = (void*)objc_msgSend;
			//objc_msgSendUpdate(parent, updateSel, dt);
			((void(*)(id,SEL,float))objc_msgSend)(parent, updateSel, dt);
		}
		
		// update the time spent in this state.
		stateTime += dt;
	}
}


@end
