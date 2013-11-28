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
    BPUsersTableViewController *usersTableViewController = [[BPUsersTableViewController alloc] init];
    [usersTableViewController setTitle:@"TableViewTitle"];
    usersTableViewController.view.frame = CGRectMake(0,100,350, 500);
    BPCommentViewController *commentViewController = [[BPCommentViewController alloc] init];
    [commentViewController setTitle:@"CommentViewTitle"];
    [commentViewController.view setBackgroundColor:[UIColor whiteColor]];
    commentViewController.view.frame = CGRectMake(500, 100, 500, 500);
    //BPCommentSplitViewController *commentSplitViewController = [[BPCommentSplitViewController alloc] init];
    //commentSplitViewController.view.frame = [[UIScreen mainScreen] applicationFrame];
    //NSArray *twoViewControllers = @[usersTableViewController, commentViewController];
    //commentSplitViewController.viewControllers = twoViewControllers;
    [self.view addSubview:usersTableViewController.view];
    [self.view addSubview:commentViewController.view];
}

@end
