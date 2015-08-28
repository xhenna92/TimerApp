//
//  CountdownObject.m
//  Time
//
//  Created by Henna on 8/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "CountdownObject.h"

@implementation CountdownObject

-(void) initializeWith: (NSString*)aName and: (int) aNumber{
    self.name = aName;
    self.numberOfSeconds = aNumber;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:0];
    [comps setMonth:0];
    [comps setYear:0];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];

    self.dateInSeconds = [NSDate dateWithTimeInterval:self.numberOfSeconds sinceDate:date];
}

@end
