//
//  StateMachine.h
//
//  Created by David Hart on 2010/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StateMachine : NSObject 
{
	id parent;
	NSString* nextState;	// next state (base name of the function trio).
	NSString* curState;		// current state (base name of the functino trio).
	float stateTime;		// current time spent in this state.
	BOOL debug;				// use this to debug state transitions.		
}

- (id)   init:        (id) parentClass;
- (void) SwitchState: (NSString*) newState;
- (void) Update:      (float) dt;
- (void) Debug:       (NSString*) stateName;

@property (nonatomic, readonly) float stateTime;
@property (nonatomic, readonly) NSString* nextState;
@property (nonatomic, readonly) NSString* curState;
@property (nonatomic)           BOOL debug;

@end
