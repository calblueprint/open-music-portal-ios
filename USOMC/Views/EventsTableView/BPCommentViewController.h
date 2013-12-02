//
//  BPCommentViewController.h
//  USOMC
//
//  Created by Allison Leong on 11/27/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPViewController.h"

@interface BPCommentViewController : BPViewController
@property (nonatomic) NSString *eventName;
-(void)makeInstructionView;
-(void)makeCommentField;
@end
