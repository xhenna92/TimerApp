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
    self.tableView.backgroundColor = [UIColor darkGrayColor];
   
    self.currIndexColor = 0;
    UIColor *color = [UIColor babyBlueColor];
    self.colorArray = [color colorSchemeOfType:ColorSchemeAnalagous];
    self.navigationItem.title = @"Timer";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presetTimerPicker)];
    //[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add:)] autorelease];
    
    self.data = [TimerModel sharedInstance];
    [self.data initializeModel];
    
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void) presetTimerPicker{
    // create a reference to Main.storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // create a new instance of UIViewController from our storyboard
    PresetTimerSelectViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"presetTimerPicker"];
    
    
    // set any properties on viewController
    //viewController.planet = [self.planets objectAtIndex:0];
    
    // tell the UINavigationController to push the new view controller on to the stack
    [self.navigationController presentModalViewController:viewController animated:YES];

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
