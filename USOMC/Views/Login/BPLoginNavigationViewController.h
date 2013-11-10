//
//  BPLoginNavigationViewController.h
//  USOMC
//
//  Created by William Tang on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPNavigationController.h"
#import "BPEventsNavigationController.h"

@interface BPLoginNavigationViewController : BPNavigationController {
  NSMutableDictionary *params;
  BPEventsNavigationController *eventsNavigationController;
}

@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) BPEventsNavigationController *eventsNavigationController;

@end
