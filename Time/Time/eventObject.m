//
//  eventObject.m
//  Time
//
//  Created by Henna on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "eventObject.h"

@implementation eventObject

-(void) setDateWithMonth:(NSInteger)month andDay:(NSInteger)day andYear:(NSInteger) year{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comps];
    self.endDate = date;
}

@end
