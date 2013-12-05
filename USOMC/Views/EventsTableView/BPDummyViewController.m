//
//  BPDummyViewController.m
//  USOMC
//
//  Created by Allison Leong on 11/28/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPDummyViewController.h"

@interface BPDummyViewController ()
@end

@implementation BPDummyViewController
@synthesize contestants;
@synthesize eventId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    float tableWidth = 350;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, tableWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contestants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdD";
    BPUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BPUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BPUser *cell_user = [self.contestants objectAtIndex:indexPath.row];
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", cell_user.firstName, cell_user.lastName];
    cell.textLabel.text = firstLast;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.commentViewController.view removeFromSuperview];
    
    BPContestant *cell_contestant = [self.contestants objectAtIndex:indexPath.row];
    NSLog(@"selected DummyViewController ContestantId: %d", [cell_contestant.contestantId intValue]);
    float tableWidth = 350;
    self.commentViewController = [[BPCommentViewController alloc] init];
    [self.commentViewController setEventId:self.eventId];
    [self.commentViewController setContestant:cell_contestant];
    [self.commentViewController setJudge:self.judge];
    [self.commentViewController loadExistingComments];
    [self.commentViewController makeCommentField];
    [self.commentViewController makeLabels];
    [self.commentViewController displayComments];
    [self.commentViewController.view setBackgroundColor:[UIColor whiteColor]];
    self.commentViewController.view.frame = CGRectMake(tableWidth, 64, self.view.frame.size.width - tableWidth, self.view.frame.size.height);
    [self.view addSubview:self.commentViewController.view];

    
}



- (void)makeSplitView {
    NSLog(@"DummyViewController makeSplitView");
    NSLog(@"%f", self.view.frame.size.height);
    float tableWidth = 350;
    self.commentViewController = [[BPCommentViewController alloc] init];
    [self.commentViewController setJudge: self.judge];
    [self.commentViewController setEventId: self.eventId];
    [self.commentViewController setTitle:@"CommentViewTitle"];
    [self.commentViewController makeInstructionView];
    //[self.commentViewController makeCommentField];
    [self.commentViewController.view setBackgroundColor:[UIColor whiteColor]];
    self.commentViewController.view.frame = CGRectMake(tableWidth, 64, self.view.frame.size.width - tableWidth, self.view.frame.size.height);
    //[self.view addSubview:usersTableViewController.tableView];
    [self.view addSubview:self.commentViewController.view];
}

@end
