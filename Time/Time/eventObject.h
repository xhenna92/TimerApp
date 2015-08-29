//
//  eventObject.h
//  Time
//
//  Created by Henna on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventObject : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSDate *endDate;
-(void) setDateWithMonth:(NSInteger)month andDay:(NSInteger)day andYear:(NSInteger) year;

@end
