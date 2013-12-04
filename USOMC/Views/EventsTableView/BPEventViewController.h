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
#import "BPJudge.h"

@interface BPEventViewController : BPViewController

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger eventId;
@property (nonatomic) NSString *roomNumber;
@property (nonatomic) NSArray *contestants;
@property (nonatomic) BPJudge *judge;
//@property (nonatomic) NSArray *judgeList;
//@property (nonatomic) NSDate *startTime;
//@property (nonatomic) NSDate *endTime;
@property (nonatomic) BPEventsNavigationController *eventsNavigationController;
@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

- (void)makeLabels;
- (void)makeButtons;

@end
