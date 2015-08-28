//
//  TimerModel.h
//  Time
//
//  Created by Henna on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerModel : NSObject
@property (nonatomic) NSMutableArray *countdowns;

-(void) initializeModel;

+ (TimerModel *)sharedInstance;
@end
