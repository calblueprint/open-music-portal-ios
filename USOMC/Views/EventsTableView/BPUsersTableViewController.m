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
        [self setContestants:@[@"Peeta", @"Mulan", @"Qian Po"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self.tableView addSubview:refresh];
    [self refreshTable:self.refreshControl];
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
  return 3;//[self.contestants count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"Selected row at indexpath %d", indexPath.row);
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
    static NSString *CellIdentifier = @"cellIdD";
    BPUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BPUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
  //UNCOMMENT FOLLOWING LINES WHEN DATABASE HAS DATA
  /*
    BPUser *cell_user = [self.contestants objectAtIndex:indexPath.row];
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", cell_user.firstName, cell_user.lastName];
    cell.textLabel.text = firstLast;
    NSLog(@"cell_event.name is %@", firstLast);
   */
  NSLog(@"Setting Cell Text Label to %@", [self.contestants objectAtIndex:indexPath.row]);
  cell.textLabel.text = [self.contestants objectAtIndex:indexPath.row];
  return cell;
}

- (void)refreshTable: (UIRefreshControl *)calledRefreshControl {
    NSLog(@"Refresh Users table");
    [calledRefreshControl beginRefreshing];
    [self loadUsers];
}

- (void)loadUsers {
    NSString *pathString = [NSString stringWithFormat: @"events/%d/users", (self.eventId+1)];
    NSLog(@"sending objectRequestOperation to path: %@", pathString);
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                              method:RKRequestMethodGET
                                                                              path:pathString
                                                                              parameters:nil];
    NSLog(@"about to run RKObjectRequestOperation");
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[BPUser.usersResponseDescriptor]];
    NSLog(@"finished RKObjectRequestOperation");
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //UNCOMMENT LINE BELOW WHEN DATABASE HAS DATA
        //[self setContestants:[mappingResult.dictionary objectForKey:@"users"]];
        NSLog(@"setContestants");
        [self setContestants:@[@"Peeta", @"Mulan", @"Qian Po"]];
        [self.refreshControl endRefreshing];
        NSLog(@"LOADED Contestants: %@", self.contestants);
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.refreshControl endRefreshing];
        NSLog(@"ERROR: BPUsersTableViewController.loadUsers");
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];
    
}




@end
