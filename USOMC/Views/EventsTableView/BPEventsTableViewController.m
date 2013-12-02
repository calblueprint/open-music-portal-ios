//
//  BPEventsTableViewController.m
//  USOMC
//
//  Created by Mark Miyashita on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPEventsTableViewController.h"

@interface BPEventsTableViewController ()
@property (nonatomic, strong) BPEventViewController *subEvent;
@end

@implementation BPEventsTableViewController
@synthesize judge;
@synthesize events;
@synthesize eventsNavigationController;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
    [self setTitle:@"Events"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
  [refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refresh;
  [self.tableView addSubview:refresh];
  [self refreshTable:self.refreshControl];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  // If you're serving data from an array, return the length of the array:
  NSLog(@"self.events count %d", [self.events count]);
  return [self.events count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPEvent *cell_event = [self.events objectAtIndex:indexPath.row];
    NSLog(@"self.events objectAtIndex: %d: %@", indexPath.row, cell_event.name);
    NSInteger rowNum = indexPath.row;
    self.subEvent = [[BPEventViewController alloc] init];
    [self.subEvent setName:cell_event.name];
    [self.subEvent setTitle: cell_event.name];
    [self.subEvent setEncid: rowNum];
    [self.subEvent setRoomNumber:cell_event.roomNumber];
    [self.subEvent makeLabels];
    [self.subEvent makeButtons];
    [self.subEvent.view setBackgroundColor:[UIColor whiteColor]];
    [self.subEvent setEventsNavigationController:self.eventsNavigationController];
    [self.eventsNavigationController pushViewController:self.subEvent animated:YES];
  
 }

- (BPEventsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"cellIdD";
  BPEventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[BPEventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
  }
  
  BPEvent *cell_event = [self.events objectAtIndex:indexPath.row];
  cell.textLabel.text = cell_event.name;
  NSLog(@"cell_event.name is %@", cell_event.name);
  return cell;
}

- (void)refreshTable: (UIRefreshControl *)calledRefreshControl {
  NSLog(@"Refresh Events table");
  [calledRefreshControl beginRefreshing];
  [self loadEvents];
}

- (void)loadEvents {
  NSLog(@"entering loadEvents method");
  NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                method:RKRequestMethodGET
                                                                path:@"events/index"
                                                                parameters:nil];
  NSLog(@"about to run RKObjectRequestOperation");
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[BPEvent.eventsResponseDescriptor]];
  NSLog(@"finished RKObjectRequestOperation");
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    [self setEvents:[mappingResult.dictionary objectForKey:@"events"]];
    NSLog(@"setEvents");
    [self.refreshControl endRefreshing];
    NSLog(@"LOADED Events: %@", self.events);
    [self.tableView reloadData];
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    [self.refreshControl endRefreshing];
    NSLog(@"ERROR: BPEventsTableViewController.loadEvents");
  }];
  
  [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];
  
}


@end
