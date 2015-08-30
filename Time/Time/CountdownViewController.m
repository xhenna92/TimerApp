//
//  CountdownViewController.m
//  Time
//
//  Created by Kaisha Jones on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "CountdownViewController.h"
#import "CountdownObject.h"
#import "Colours.h"
#import "circleView.h"


@interface CountdownViewController () {
    
    int afterRemainder;
    int remainder;
    NSTimeInterval countDownInterval;
    circleView * loader;
    BOOL initLoader;
    
}
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (nonatomic) NSArray *colorArray;
@property (nonatomic) NSInteger currIndexColor;
@property (weak, nonatomic) IBOutlet UIDatePicker *CountdownPickerView;
@property (weak, nonatomic) IBOutlet UILabel *CountdownTimerLabel;
@property (weak, nonatomic) IBOutlet UIButton *CountdownStartButton;
@property (weak, nonatomic) IBOutlet UIButton *CountdownPauseButton;
@property (nonatomic) BOOL isStart;
@property (nonatomic) BOOL isInitialStart;

@property (nonatomic) BOOL isResumed;

@property (nonatomic) NSTimer *timer;
@property NSTimeInterval currentNumber;

@property (nonatomic)NSMutableArray *hoursArray;
@property (nonatomic)NSMutableArray *minutesArray;
@property (nonatomic)NSDateComponents *NSCalendar;
@property (nonatomic)NSDateComponents *NSHourUnitCalendar;
@property (nonatomic)UIPickerView *countDownDuration;



@end

@implementation CountdownViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    initLoader = YES;
    
    self.navigationItem.title = @"Countdown Timer";
    
    UIColor *color = [UIColor babyBlueColor];
    self.colorArray = [color colorSchemeOfType:ColorSchemeAnalagous];
    self.currIndexColor = 0;
    
    //BOOLs that handle button display
    self.isStart = YES;
    self.isResumed = YES;
    self.isInitialStart=YES;
    
    //initialize colors/shapes for views and buttons
    self.backgroundView.backgroundColor = [UIColor black75PercentColor];
    self.CountdownPickerView.datePickerMode = UIDatePickerModeCountDownTimer;
    self.CountdownPickerView.backgroundColor = [UIColor black75PercentColor];
    [self.CountdownPickerView setValue:[UIColor whiteColor] forKey:@"textColor"];
    self.CountdownPickerView.hidden = NO;
    self.CountdownStartButton.backgroundColor = [UIColor emeraldColor];
    self.CountdownStartButton.layer.cornerRadius = self.CountdownStartButton.bounds.size.width/2;
    self.CountdownPauseButton.backgroundColor = [UIColor babyBlueColor];
    self.CountdownPauseButton.layer.cornerRadius = self.CountdownPauseButton.bounds.size.width/2;
    self.CountdownPauseButton.alpha = 0.5;
    self.CountdownTimerLabel.hidden = YES;
    self.CountdownTimerLabel.textColor = [UIColor whiteColor];
    
    //change the timer of the picker to chosen time
    [self.CountdownPickerView setDate:self.countdownInfo.dateInSeconds];
    

    





}


- (void)viewWillDisappear:(BOOL)animated{
    
    [self.timer invalidate];

}
    
- (void) updateCountDown {
    afterRemainder --;
    loader.remainder = afterRemainder;
    
    if (loader.remainder > 0) {
        [loader setNeedsDisplay];
    }
    else{
        [self.timer invalidate];
        self.timer = nil;
    }
    
//    int hours = (int)(afterRemainder/(60*60));
//    int mins = (int)(((int)afterRemainder/60) - (hours * 60));
//    int secs = (int)(((int)afterRemainder - (60 *mins) - (60 * hours * 60)));
//
//    
//    [self changeBGColor];
//    NSString *timeDisplay = [[NSString alloc] initWithFormat:@"%02u : %02u : %02u", hours, mins, secs];
//    
//    self.CountdownTimerLabel.text = timeDisplay;
    
}

-(void) changeBGColor{
    
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
    UIColor *color = [self.colorArray objectAtIndex:rndValue];
    self.CountdownTimerLabel.backgroundColor = color;
}



//start tapped and stop tapped
- (IBAction)CountdownStartButtonTapped:(id)sender {
    if(self.isInitialStart){
        self.isInitialStart = NO;
        loader = [[circleView alloc] initWithFrame:self.loaderView.bounds];
        [loader setTranslatesAutoresizingMaskIntoConstraints:NO];
        loader.center =self.loaderView.center;
        
        loader.remainder = self.countdownInfo.numberOfSeconds;
        loader.total = self.countdownInfo.numberOfSeconds;
        [self.view addSubview:loader];
    }
    if (self.isStart) {
        
        countDownInterval = (NSTimeInterval)_CountdownPickerView.countDownDuration;
        remainder = countDownInterval;
        afterRemainder = countDownInterval - remainder%60;
        
        //change the text in start button to cancel and enable the pause button
        self.CountdownStartButton.backgroundColor = [UIColor brickRedColor];
        self.CountdownPauseButton.alpha = 1;
        self.CountdownPauseButton.enabled = YES;
        
        //change the value of the bool isStart bc we're at stop now
        self.isStart = NO;
        
        //create a timer
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        
        afterRemainder++;
        
        [self updateCountDown];
        
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.CountdownPickerView setHidden:YES];
        [self.CountdownTimerLabel setHidden:NO];

    }
    
    else {
        self.CountdownStartButton.backgroundColor = [UIColor emeraldColor];

        [self.CountdownPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.CountdownPickerView setHidden: NO];
        [self.CountdownTimerLabel setHidden: YES];
        self.CountdownPauseButton.enabled = NO;
        self.CountdownPauseButton.alpha = 0.5;
        [self.timer invalidate];
        [loader setHidden:YES];
        self.isStart = YES;
        self.isInitialStart = YES;
        self.isResumed = YES;
        initLoader = YES;
        
    }
    
}

- (IBAction)pausedTapped:(UIButton *)sender {
    
    if (self.isResumed) {
        
        self.isResumed = NO;
        [self.timer invalidate];
        [self.CountdownPauseButton setTitle:@"Resume" forState:UIControlStateNormal];
    } else {
        self.isResumed = YES;
        
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.CountdownPauseButton setTitle:@"Pause" forState:UIControlStateNormal];

    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
