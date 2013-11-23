//
//  BPEventViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPViewController.h"
#import "BPEvent.h"

@interface BPEventViewController : BPViewController

@property (nonatomic) NSString *name;
//@property (nonatomic) NSInteger *roomNumber;
//@property (nonatomic) NSArray *contestantList;
//@property (nonatomic) NSArray *judgeList;
//@property (nonatomic) NSDate *startTime;
//@property (nonatomic) NSDate *endTime;

@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

- (void)makeLabels;

@end
