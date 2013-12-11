//
//  BPDisplayRankingsTableViewController.m
//  USOMC
//
//  Created by Allison Leong on 12/10/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPDisplayRankingsTableViewController.h"

@interface BPDisplayRankingsTableViewController ()

@end

@implementation BPDisplayRankingsTableViewController
@synthesize rankings;
@synthesize eventId;
@synthesize eventsNavigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Contestant Rankings"];
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
    return [self.rankings count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"entering DisplayRankingsViewController cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"cellIdD";
    BPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setNuiClass:@"rankingCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BPRanking *cell_ranking = [self.rankings objectAtIndex:indexPath.row];
    
    if (cell_ranking.rank != NULL) {
        cell.textLabel.text = [NSString stringWithFormat:@"%d. %@ %@", [cell_ranking.rank intValue], cell_ranking.firstName, cell_ranking.lastName];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Not Yet Ranked: %@ %@", cell_ranking.firstName, cell_ranking.lastName];
    }
    return cell;
}

- (void)refreshTable: (UIRefreshControl *)calledRefreshControl {
    [calledRefreshControl beginRefreshing];
    [self loadRankings];
}

- (void)loadRankings {
    NSLog(@"entering displayRankingsViewController loadRankings");
    NSString *pathString = [NSString stringWithFormat:@"events/%d/rankings",(int)self.eventId];
    NSLog(@"displayRankingsViewController loadRankings pathString is : %@", pathString);
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                               method:RKRequestMethodGET
                                                                                 path:pathString
                                                                           parameters:nil];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[BPRanking.rankingsResponseDescriptor]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self setRankings:[mappingResult.dictionary objectForKey:@"contestants"]];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        NSLog(@"LOADED rankings: %@", self.rankings);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: BPdisplayRankingsViewController.loadExistingComments");
        [self.refreshControl endRefreshing];
    }];
    NSLog(@"!!!!!self.rankings: %@", self.rankings);
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];
    
}




@end
