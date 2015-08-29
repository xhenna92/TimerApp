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
    [CDobject initializeWith:@"Custom Timer" and:60];
    [self.countdowns addObject:CDobject];
    
    CountdownObject * CDobject2 = [[CountdownObject alloc]init];
    [CDobject2 initializeWith:@"Quick Minute" and:60];
    [self.countdowns addObject:CDobject2];
    
    CountdownObject * CDobject3 = [[CountdownObject alloc]init];
    [CDobject3 initializeWith:@"Pizza" and:180];
    [self.countdowns addObject:CDobject3];

    CountdownObject * CDobject4 = [[CountdownObject alloc]init];
    [CDobject4 initializeWith:@"Party" and:600];
    [self.countdowns addObject:CDobject4];
    
    CountdownObject * CDobject5 = [[CountdownObject alloc]init];
    [CDobject5 initializeWith:@"Exercise" and:400];
    [self.countdowns addObject:CDobject5];
    
    CountdownObject * CDobject6 = [[CountdownObject alloc]init];
    [CDobject6 initializeWith:@"Bed" and:6000];
    [self.countdowns addObject:CDobject6];


    
}

@end
