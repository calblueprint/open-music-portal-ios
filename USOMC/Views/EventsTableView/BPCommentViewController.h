//
//  BPCommentViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/27/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//
#import "Restkit/Restkit.h"
#import "BPViewController.h"
#import "BPJudge.h"
#import "BPContestant.h"
#import "BPComment.h"

@interface BPCommentViewController : BPViewController<UITextFieldDelegate>
@property (nonatomic) NSString *eventName;
@property (nonatomic) NSInteger eventId;
@property (nonatomic) BPContestant *contestant;
@property (nonatomic) BPJudge *judge;
@property (nonatomic) NSArray *comments;
-(void)makeInstructionView;
-(void)makeCommentField;
-(void)makeLabels;
-(void)loadExistingComments;
-(void)displayComments;
@end
