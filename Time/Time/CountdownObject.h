//
//  CountdownObject.h
//  Time
//
//  Created by Henna on 8/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountdownObject : NSObject

@property (nonatomic) NSString * name;
@property int numberOfSeconds;
@property (nonatomic) NSDate *dateInSeconds;
//maybe add an image later
-(void) initializeWith: (NSString*)aName and: (int) aNumber;

@end
