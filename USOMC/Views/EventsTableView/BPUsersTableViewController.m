//
//  BPUsersTableViewController.m
//  USOMC
//
//  Created by Allison Leong on 11/27/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPUsersTableViewController.h"

@interface BPUsersTableViewController ()

@end

@implementation BPUsersTableViewController
@synthesize contestants;
@synthesize eventId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Contestants"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  NSLog(@"viewDidLoad is called in BPUsersTableViewController and self.contestants.count is %d", self.contestants.count);
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    NSLog(@"self.contestants count %d", [self.contestants count]);
  return [self.contestants count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"Selected row at indexpath %d", indexPath.row);
  BPUser *cell_user = [self.contestants objectAtIndex:indexPath.row];
  BPCommentViewController *newCommentView = [[BPCommentViewController alloc] init];
  
    /*
    BPEvent *cell_user = [self.contestants objectAtIndex:indexPath.row];
    NSLog(@"self.events objectAtIndex: %d: %@", indexPath.row, cell_user.name);
    self.subEvent = [[BPEventViewController alloc] init];
    [self.subEvent setName:cell_event.name];
    [self.subEvent setTitle: cell_event.name];
    [self.subEvent makeLabels];
    [self.subEvent makeButtons];
    [self.subEvent.view setBackgroundColor:[UIColor whiteColor]];
    [self.subEvent setEventsNavigationController:self.eventsNavigationController];
    [self.eventsNavigationController pushViewController:self.subEvent animated:YES];
     */
    
}

- (BPUserTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"cellIdD";
    BPUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BPUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
    BPUser *cell_user = [self.contestants objectAtIndex:indexPath.row];
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", cell_user.firstName, cell_user.lastName];
    cell.textLabel.text = firstLast;
    NSLog(@"cell_event.name is %@", firstLast);
   return cell;
}





@end
