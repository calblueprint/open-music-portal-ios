//
//  BPLoginViewController.h
//  USOMC
//
//  Created by William Tang on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPViewController.h"

#import "BPEventsNavigationController.h"

@interface BPLoginViewController : BPViewController {
  UILabel *verifiedText;
  UITextField *usernameField;
  
  BPEventsNavigationController *eventsNavigationController;
}

@property (nonatomic, assign) UILabel *verifiedText;
@property (nonatomic, assign) UITextField *usernameField;
@property (nonatomic, retain) BPEventsNavigationController *eventsNavigationController;

- (id) init:(BPEventsNavigationController *)eventPage;
@end
