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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeSplitView {
    NSLog(@"make split view");
    NSLog(@"%f", self.view.frame.size.height);
    float tableWidth = 350;
    BPUsersTableViewController *usersTableViewController = [[BPUsersTableViewController alloc] init];
    usersTableViewController.view.frame = CGRectMake(0, 64, tableWidth, self.view.frame.size.height);
    usersTableViewController.view.backgroundColor = [UIColor whiteColor];
    [usersTableViewController setEventId:self.eventId];
    [usersTableViewController setTitle:@"TableViewTitle"];
    BPCommentViewController *commentViewController = [[BPCommentViewController alloc] init];
    [commentViewController setTitle:@"CommentViewTitle"];
    [commentViewController makeInstructionView];
    [commentViewController makeCommentField];
    [commentViewController.view setBackgroundColor:[UIColor whiteColor]];
    commentViewController.view.frame = CGRectMake(tableWidth, 64, self.view.frame.size.width - tableWidth, self.view.frame.size.height);
    [self.view addSubview:usersTableViewController.view];
    [self.view addSubview:commentViewController.view];
}

@end
