//
//  TimerTableViewController.m
//  Time
//
//  Created by Henna on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerTableViewController.h"
#import "CountdownViewController.h"
#import "CountdownObject.h"
#import "PresetTimerSelectViewController.h"
#import "TimerModel.h"
#import "Colours.h"

@interface TimerTableViewController ()
    @property (nonatomic) TimerModel * data;
    @property (nonatomic) NSArray *colorArray;
    @property (nonatomic) NSInteger currIndexColor;
@end

@implementation TimerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Timers";
    
    self.tableView.backgroundColor = [UIColor black75PercentColor];
    
    UIColor *color = [UIColor babyBlueColor];
    self.colorArray = [color colorSchemeOfType:ColorSchemeAnalagous];
    self.currIndexColor = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presetTimerPicker)];
    
    self.data = [TimerModel sharedInstance];
    [self.data initializeModel];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void) presetTimerPicker{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PresetTimerSelectViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"presetTimerPicker"];
    [self.navigationController presentViewController:viewController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[CountdownViewController class]]){
    NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
    
    CountdownObject * selected = [self.data.countdowns objectAtIndex:indexPath.row];
    CountdownViewController * destination = segue.destinationViewController;
    destination.countdownInfo = selected;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.countdowns.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimerIndexCellIdentifier" forIndexPath:indexPath];
    
    CountdownObject *object = [self.data.countdowns objectAtIndex:indexPath.row];
    cell.textLabel.text = object.name;
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
    return cell;
}

@end
