//
//  BPDummyViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/28/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPViewController.h"
#import "BPUserTableViewCell.h"
#import "BPCommentViewController.h"
#import "BPUser.h"
#import "BPJudge.h"
#import "BPContestant.h"
#import "UIView+Nui.h"

@interface BPDummyViewController : BPViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSArray *contestants;
@property (nonatomic) NSInteger eventId;
@property (nonatomic) BPJudge *judge;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BPCommentViewController *commentViewController;
-(void)makeSplitView;
@end

