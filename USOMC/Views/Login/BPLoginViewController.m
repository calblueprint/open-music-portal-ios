//
//  BPLoginViewController.m
//  USOMC
//
//  Created by William Tang on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPLoginViewController.h"

@interface BPLoginViewController ()

@end

@implementation BPLoginViewController
@synthesize verifiedText = _verfifiedText;
@synthesize usernameField = _usernameField;
@synthesize eventsNavigationController = _eventsNavigationController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = @"Welcome to the USOMC Judging App!";
    
  }
  return self;
}

-(id)init:(BPEventsNavigationController *)eventPage {
  self = [self init];
  self.eventsNavigationController = eventPage;
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  UITextField *usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 310, 280, 20)];
  [usernameTextField setPlaceholder:@"Username"];
  [usernameTextField setReturnKeyType:UIReturnKeyDone];
  [usernameTextField setTag:999];
  //[usernameTextField setDelegate:self];
  [usernameTextField setKeyboardType:UIKeyboardTypeEmailAddress];
  [usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  [usernameTextField setHidden:YES];
  [self setUsernameField:usernameTextField];
  [self.view addSubview:usernameTextField];
  
  UILabel *verified = [[UILabel alloc] initWithFrame:CGRectMake(20, 350, 280, 20)];
  [verified setText:@"Invalid Login"];
  [verified setHidden:YES];
  [self setVerifiedText:verified];
  [self.view addSubview:verified];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
