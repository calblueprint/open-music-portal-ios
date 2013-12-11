//
//  BPRatingsTableViewController.h
//  
//
//  Created by William Tang on 12/7/13.
//
//

#import "BPTableViewController.h"
#import "BPRatingsTableViewCell.h"
#import "BPJudge.h"
#import "BPContestant.h"
#import <RNBlurModalView/RNBlurModalView.h>
#import "HVTableView.h"

@interface BPRatingsTableViewController : BPTableViewController

@property (nonatomic) NSInteger eventID;
@property (nonatomic, retain) BPJudge *judge;
@property (nonatomic, retain) NSArray *contestants;
@end
