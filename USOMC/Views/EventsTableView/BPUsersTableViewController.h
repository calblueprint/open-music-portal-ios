//
//  BPUsersTableViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/27/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//
#import "Restkit/Restkit.h"
#import "BPTableViewController.h"
#import "BPUserTableViewCell.h"


@interface BPUsersTableViewController : BPTableViewController
@property (nonatomic) NSArray *contestants;
@property (nonatomic) NSInteger eventId;

@end
