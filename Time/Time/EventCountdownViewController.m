//
//  EventCountdownViewController.m
//  Time
//
//  Created by Henna on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "EventCountdownViewController.h"

@interface EventCountdownViewController ()

@property (nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *CDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (nonatomic) NSDate *startDate;
@property (weak, nonatomic) IBOutlet UIView *labelHolder;
@property (nonatomic) NSInteger picIndex;

@end

@implementation EventCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picIndex = 0;
    self.navigationItem.title = self.obj.name;
    self.labelHolder.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabel {
    
    NSInteger rndValue = 0 + arc4random() % (2 - 0);
    if (self.picIndex == rndValue) {
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
    self.picIndex = rndValue;
    
    NSString *index = [NSString stringWithFormat: @"%d", self.picIndex];

    self.backgroundImage.image = [UIImage imageNamed:index];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    self.startDate = [NSDate date];
    
    NSDate *end = [gregorian dateBySettingHour:0 minute:0 second:0 ofDate:self.obj.endDate options:0];
    //self.startDate = [gregorian dateBySettingHour:0 minute:0 second:0 ofDate:self.startDate options:0];

    unsigned int unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour |NSCalendarUnitSecond | NSCalendarUnitMinute;

    NSDateComponents *comps = [gregorian components:unitFlags fromDate: self.startDate toDate: end options:0];
    
    NSInteger days = [comps day];
    NSInteger months = [comps month];
    NSInteger years = [comps year];
    NSInteger hours = [comps hour];
    NSInteger minutes = [comps minute];
    NSInteger seconds = [comps second];
    
    self.CDLabel.text = [NSString stringWithFormat:@"%d months %d days  %d years \r %d hours %d minutes %d seconds", months, days, years, hours, minutes, seconds];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
