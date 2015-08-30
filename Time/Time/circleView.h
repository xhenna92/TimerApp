//
//  circleView.h
//  Time
//
//  Created by Henna on 8/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface circleView : UIView
@property (nonatomic) int remainder;
@property (nonatomic) int total;
@property (nonatomic) CGPoint center;
@property (nonatomic) NSArray *colorArray;
@property (nonatomic) NSInteger currIndexColor;
@end

