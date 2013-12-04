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

@interface BPCommentViewController : BPViewController<UITextFieldDelegate>
@property (nonatomic) NSString *eventName;
@property (nonatomic) NSInteger eventId;
@property (nonatomic) BPUser *contestant;
@property (nonatomic) BPJudge *judge;
-(void)makeInstructionView;
-(void)makeCommentField;
-(void)makeLabels;
@end
