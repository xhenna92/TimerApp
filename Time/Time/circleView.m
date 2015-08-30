//
//  circleView.m
//  Time
//
//  Created by Henna on 8/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "circleView.h"
#import "Colours.h"

@interface circleView ()

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@property (nonatomic) UILabel *timeLabel;

@end

@implementation circleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor black75PercentColor];
        UIColor *color = [UIColor babyBlueColor];
        self.colorArray = [color colorSchemeOfType:ColorSchemeAnalagous];
        self.currIndexColor = 0;
        // Determine our start and stop angles for the arc (in radians)
        self.startAngle = M_PI * 1.5;
        self.endAngle = self.startAngle + (M_PI * 2);
        
        
        self.timeLabel = [[UILabel  alloc] initWithFrame:self.bounds];
        self.timeLabel.center = self.center;
        self.timeLabel.text = @"00:00:00";
        self.timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:42.5];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.timeLabel];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Display our percentage as a string
    
    int hours = (int)(self.remainder/(60*60));
    int mins = (int)(((int)self.remainder/60) - (hours * 60));
    int secs = (int)(((int)self.remainder - (60 *mins) - (60 * hours * 60)));
    
    NSString *textContent = [NSString stringWithFormat:@"%02u : %02u : %02u", hours, mins, secs];
    _timeLabel.text = textContent;

    //NSString* textContent = [NSString stringWithFormat:@"%d", self.remainder];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    
    float fraction = (float)self.remainder/self.total;
    
    
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width/2 , rect.size.height/2)
                          radius:50
                      startAngle:_startAngle
                        endAngle:(_endAngle - _startAngle) * fraction + _startAngle
                       clockwise:YES];
    
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 50*M_PI;
    
    
    
    NSInteger rndValue = 0 + arc4random() % (2 - 0);
    if (self.currIndexColor == rndValue) {
        if (rndValue==0) {
            rndValue ++;
        }
        else if(rndValue ==2){
            rndValue--;
        }
        else{
            rndValue++;
        }
    }
    self.currIndexColor = rndValue;
    UIColor *bgColor = [self.colorArray objectAtIndex:rndValue];
    
    [bgColor setStroke];
    
    [bezierPath stroke];
    CAShapeLayer *progressLayer = [[CAShapeLayer alloc] init];
    [progressLayer setPath:bezierPath.CGPath];
    [progressLayer setStrokeColor:bgColor.CGColor];
    [progressLayer setFillColor:bgColor.CGColor];
    [progressLayer setLineWidth:50];
    [self.layer addSublayer:progressLayer];
    // Text Drawing
    [self addSubview:self.timeLabel];
    //CGRect textRect = CGRectMake(rect.size.width/(M_PI*M_PI*M_PI*M_PI), (rect.size.height / 2.0) - 45/2.0, rect.size.width, 45);
    //[[UIColor clearColor] setFill];
    //[textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 42.5] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    //NSLog(@"%@", textRect);
    
}

@end
