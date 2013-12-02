//
//  BPAppDelegate.h
//  USOMC
//
//  Created by Mark Miyashita on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "BPLoginNavigationController.h"
#import "BPLoginViewController.h"
#import "BPEventsNavigationController.h"
#import "BPEventsTableViewController.h"
#import "KeychainItemWrapper.h"
#import "BPJudge.h"
#import "BPEventViewController.h"

@interface BPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BPLoginNavigationController *loginNavigationController;
@property (strong, nonatomic) BPEventsTableViewController *eventTableViewController;
@property (strong, nonatomic) BPEventsNavigationController *homeViewController;

@end
