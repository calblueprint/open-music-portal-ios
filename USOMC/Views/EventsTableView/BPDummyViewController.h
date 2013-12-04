//
//  BPDummyViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/28/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPViewController.h"
#import "BPUsersTableViewController.h"
#import "BPCommentViewController.h"
#import "BPCommentSplitViewController.h"
#import "BPUser.h"
#import "BPJudge.h"
#import "BPContestant.h"

@interface BPDummyViewController : BPViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSArray *contestants;
@property (nonatomic) NSInteger eventId;
@property (nonatomic) BPJudge *judge;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BPCommentViewController *commentViewController;
-(void)makeSplitView;
@end

