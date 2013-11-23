//
//  BPEventsNavigationController.h
//  USOMC
//
//  Created by Mark Miyashita on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPNavigationController.h"
#import "BPJudge.h"

@interface BPEventsNavigationController : BPNavigationController
@property (nonatomic, retain) BPJudge *judge;

@end
