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

@interface BPDummyViewController : BPViewController
@property (nonatomic) NSArray *contestants;
@property (nonatomic) NSInteger eventId;
-(void)makeSplitView;
@end

