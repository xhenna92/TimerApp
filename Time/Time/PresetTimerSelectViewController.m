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


@interface PresetTimerSelectViewController ()
@property(nonatomic) TimerModel *data;
@end

@implementation PresetTimerSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [TimerModel sharedInstance];
    // Do any additional setup after loading the view.
}
- (IBAction)pizzaTouched:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    CountdownObject * CDobject = [[CountdownObject alloc]init];
    [CDobject initializeWith:@"Pizza" and:180];
    [self.data.countdowns addObject:CDobject];
}
- (IBAction)partyTouched:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    CountdownObject * CDobject = [[CountdownObject alloc]init];
    [CDobject initializeWith:@"Party" and:600];
    [self.data.countdowns addObject:CDobject];
}
- (IBAction)Countdown3:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    CountdownObject * CDobject = [[CountdownObject alloc]init];
    [CDobject initializeWith:@"Exercise" and:400];
    [self.data.countdowns addObject:CDobject];
}
- (IBAction)Countdown4:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    CountdownObject * CDobject = [[CountdownObject alloc]init];
    [CDobject initializeWith:@"Home" and:6000];
    [self.data.countdowns addObject:CDobject];
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
