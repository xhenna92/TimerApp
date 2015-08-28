//
//  TimerModel.m
//  Time
//
//  Created by Henna on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerModel.h"
#import "CountdownObject.h"

@implementation TimerModel
+ (TimerModel *)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) initializeModel {
    
    self.countdowns = [[NSMutableArray alloc] init];
    
    CountdownObject * CDobject = [[CountdownObject alloc]init];
    [CDobject initializeWith:@"Custom Timer" and:120];
    [self.countdowns addObject:CDobject];
    
    CountdownObject * CDobject2 = [[CountdownObject alloc]init];
    [CDobject2 initializeWith:@"Quick Minute" and:60];
    [self.countdowns addObject:CDobject2];
    
    CountdownObject * CDobject3 = [[CountdownObject alloc]init];
    [CDobject3 initializeWith:@"Hunned Seconds" and:100];
    [self.countdowns addObject:CDobject3];
    
}

@end
