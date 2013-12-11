//
//  BPDisplayRankingsTableViewController.h
//  USOMC
//
//  Created by Allison Leong on 12/10/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPTableViewController.h"
#import "Restkit/Restkit.h"
#import "BPRanking.h"
#import "BPEventsNavigationController.h"
#import "BPTableViewCell.h"
#import "UITableViewCell+Nui.h"


@interface BPDisplayRankingsTableViewController : BPTableViewController
@property (nonatomic) NSMutableArray *rankings;
@property (nonatomic) NSInteger *eventId;
@property (nonatomic) BPEventsNavigationController *eventsNavigationController;
@property (nonatomic, assign) BPRanking *rank;
@end
