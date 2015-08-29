//
//  StopwatchViewController.m
//  Time
//
//  Created by Henna on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Colours.h"


@interface StopwatchViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UITableView *stopWatchTableView;
@property (nonatomic) NSMutableArray * data;
@property (nonatomic) BOOL initialStart;
@property (nonatomic) BOOL start;
@property (nonatomic) BOOL isLapThere;


@property int millisecondsElapsed;
@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapLabel;
@property (strong, nonatomic) NSTimer *stopWatchTimer;
@property (strong, nonatomic) NSTimer *lapTimer;
@property int lapMilliElapsed;
@property (strong, nonatomic) IBOutlet UIView *backgroundLap;

@property (nonatomic) NSArray *colorArray;
@property (nonatomic) NSInteger currIndexColor;



@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stopWatchTableView.backgroundColor = [UIColor black75PercentColor];
    self.backgroundLap.backgroundColor = [UIColor black75PercentColor];
    
    self.currIndexColor = 0;
    UIColor *color = [UIColor babyBlueColor];
    self.colorArray = [color colorSchemeOfType:ColorSchemeAnalagous];
    
    self.navigationItem.title = @"Stopwatch";
    
    self.initialStart = YES;
    self.isLapThere = YES;
    self.data = [[NSMutableArray alloc]init];

    self.lapButton.alpha = 0.5;
    self.stopWatchTableView.delegate = self;
    self.stopWatchTableView.dataSource = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//for lap and reset button
- (IBAction)captureLapTime:(UIButton *)sender {
    if(self.isLapThere){
        
        [self.data addObject:self.lapLabel.text];
        [self.stopWatchTableView reloadData];
        self.lapMilliElapsed = 0;
    }
    else{
        [self.startButton setImage: [UIImage imageNamed:@"greenButton"] forState:UIControlStateNormal];
        self.lapButton.enabled =NO;
        [self.lapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.initialStart = YES;
        self.lapButton.alpha = 0.5;
        
        [self.data removeAllObjects];
        [self.stopWatchTableView reloadData];
        
        
        
        [self.stopWatchTimer invalidate];
        [self.lapTimer invalidate];
        self.stopWatchTimer = nil;
        self.lapTimer = nil;
        self.millisecondsElapsed = 0;
        self.lapMilliElapsed = 0;
        self.lapLabel.text = [NSString stringWithFormat:@"00:00:%02d", self.lapMilliElapsed];
        self.stopwatchLabel.text = [NSString stringWithFormat:@"00:00:%02d", self.millisecondsElapsed];
    }
}

- (void)updateTimer
{
    self.millisecondsElapsed += 1;
    
    int minutes = self.millisecondsElapsed / 6000;
    int remainder_m = self.millisecondsElapsed % 6000; //remaining milliseconds
    
    
    int seconds =   remainder_m/100 ; // seconds
    int remainder_s = remainder_m % 100; //remaining seconds
    
    int millisec = remainder_s;
    
    self.stopwatchLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", minutes, seconds, millisec];
}

- (void)updateLapTimer
{
    self.lapMilliElapsed += 1;
    
    int minutes = self.lapMilliElapsed / 6000;
    int remainder_m = self.lapMilliElapsed % 6000; //remaining milliseconds
    
    
    int seconds =   remainder_m/100 ; // seconds
    int remainder_s = remainder_m % 100; //remaining seconds
    
    int millisec = remainder_s;
    
    self.lapLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", minutes, seconds, millisec];
}

//for start and stop button
- (IBAction)startButtonTapped:(UIButton *)sender {
    if(self.initialStart){
        self.initialStart = NO;
        self.start = NO;
        [self.startButton setImage: [UIImage imageNamed:@"stopButton"] forState:UIControlStateNormal];
        self.lapButton.enabled = YES;
        self.lapButton.alpha = 1.0;
        self.isLapThere = YES;
        
        //NSTimer stuff
        self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                               target:self
                                                             selector:@selector(updateTimer)
                                                             userInfo:nil
                                                              repeats:YES];
        self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                         target:self
                                                       selector:@selector(updateLapTimer)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    else if(!self.start){
        self.start = YES;
        
        [self.startButton setImage: [UIImage imageNamed:@"greenButton"] forState:UIControlStateNormal];
        [self.lapButton setTitle:@"Reset" forState:UIControlStateNormal];
        self.isLapThere = NO;
        
        [self.stopWatchTimer invalidate];
        [self.lapTimer invalidate];
        
    }
    else{
        self.start = NO;
        
        [self.startButton setImage: [UIImage imageNamed:@"stopButton"] forState:UIControlStateNormal];
        [self.lapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.isLapThere = YES;
        
        self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                               target:self
                                                             selector:@selector(updateTimer)
                                                             userInfo:nil
                                                              repeats:YES];
        self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                               target:self
                                                             selector:@selector(updateLapTimer)
                                                             userInfo:nil
                                                              repeats:YES];
    }
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
    
    
    NSInteger index = indexPath.row+1;
    NSString * cellText = [NSString stringWithFormat: @"Lap %ld \t \t", (long)index];
    NSInteger rndValue = 0 + arc4random() % (3 - 0);
    if (self.currIndexColor == rndValue) {
        if (rndValue==0) {
            rndValue ++;
        }
        else if(rndValue ==3){
            rndValue--;
        }
        else{
            rndValue++;
        }
    }
    self.currIndexColor = rndValue;
    cell.backgroundColor = [self.colorArray objectAtIndex:rndValue];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [cellText stringByAppendingString:[self.data objectAtIndex:indexPath.row]];
    
    
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
