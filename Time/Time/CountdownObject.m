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
    self.dateInSeconds = [NSDate dateWithTimeIntervalSinceReferenceDate:self.numberOfSeconds];
}

@end
