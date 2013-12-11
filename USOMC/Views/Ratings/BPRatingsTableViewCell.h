//
//  BPRatingsTableViewCell.h
//  USOMC
//
//  Created by William Tang on 12/7/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPTableViewCell.h"

@interface BPRatingsTableViewCell : BPTableViewCell

@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, retain) UILabel *label;

@end
