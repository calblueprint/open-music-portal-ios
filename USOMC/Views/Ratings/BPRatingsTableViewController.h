//
//  BPRatingsTableViewController.h
//  USOMC
//
//  Created by William Tang on 12/11/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPViewController.h"
#import <UIKit/UIKit.h>
#import "HVTableView.h"
#import "BPTableViewController.h"
#import "BPRatingsTableViewCell.h"
#import "BPJudge.h"
#import "BPContestant.h"
#import <RNBlurModalView/RNBlurModalView.h>

@interface BPRatingsTableViewController : BPViewController <HVTableViewDelegate, HVTableViewDataSource>
{
  HVTableView *myTable;
  //NSArray *cellTitles;
}

@property (nonatomic) NSInteger eventID;
@property (nonatomic, retain) BPJudge *judge;
@property (nonatomic, retain) NSArray *contestants;
@property (nonatomic, retain) NSDictionary *rankings;
@end
