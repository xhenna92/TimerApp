//
//  PresetTimerSelectViewController.m
//  Time
//
//  Created by Henna on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimerSelectViewController.h"
#import "CountdownObject.h"
#import "TimerModel.h"
#import "Colours.h"



@interface PresetTimerSelectViewController ()
@property(nonatomic) TimerModel *data;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *timerDatePicker;

@property (strong, nonatomic) IBOutlet UIView *bgView;

@end

@implementation PresetTimerSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [TimerModel sharedInstance];
    self.timerDatePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    
    self.bgView.backgroundColor = [UIColor black75PercentColor];
    [self.timerDatePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    // Do any additional setup after loading the view.
}
- (IBAction)createTapped:(UIButton *)sender {
    CountdownObject * cdObject = [[CountdownObject alloc]init];
    
    NSTimeInterval countDownInterval = (NSTimeInterval)self.timerDatePicker.countDownDuration;
    [cdObject initializeWith:self.nameLabel.text and:countDownInterval];
    
    [self.data.countdowns addObject:cdObject];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
