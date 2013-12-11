//
//  BPEventViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BPViewController.h"
#import "BPEvent.h"
#import "BPEventsNavigationController.h"
#import "BPDummyViewController.h"
#import "BPRatingsTableViewController.h"
#import "BPJudge.h"
#import "BPDisplayRankingsTableViewController.h"
#import "UILabel+Nui.h"
#import "UIButton+Nui.h"


@interface BPEventViewController : BPViewController
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger eventId;
@property (nonatomic) NSString *roomNumber;
@property (nonatomic) NSArray *contestants;
@property (nonatomic) BPJudge *judge;
@property (nonatomic) BPEventsNavigationController *eventsNavigationController;
@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;
- (void)makeLabels;
- (void)makeButtons;
@end
