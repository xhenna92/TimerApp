//
//  StopwatchViewController.m
//  Time
//
//  Created by Henna on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StopwatchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UITableView *stopWatchTableView;
@property (nonatomic) NSMutableArray * data;

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc]init];
    [self.data addObject:@"90"];
    [self.data addObject:@"40"];
    
    self.startButton.layer.cornerRadius = self.startButton.bounds.size.width/2;
    self.lapButton.layer.cornerRadius = self.lapButton.bounds.size.width/2;
    [[self.lapButton layer] setBorderWidth:2.0f];
    [[self.lapButton layer] setBorderColor: [UIColor blackColor].CGColor];
    [[self.startButton layer] setBorderWidth:2.0f];
    [[self.startButton layer] setBorderColor: [UIColor blackColor].CGColor];
    

    self.stopWatchTableView.delegate = self;
    self.stopWatchTableView.dataSource = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)captureLapTime:(UIButton *)sender {
    NSNumber * number = [NSNumber numberWithUnsignedInt:arc4random_uniform(exp2(32)-1)];
    [self.data addObject:[number stringValue]];
    [self.stopWatchTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    
    return cell;
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
