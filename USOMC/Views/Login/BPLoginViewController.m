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
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  UITextField *usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(200, 310, 280, 30)];
  [usernameTextField setPlaceholder:@"Username"];
  [usernameTextField setReturnKeyType:UIReturnKeyDone];
  [usernameTextField setTag:999];
  //[usernameTextField setDelegate:self];
  [usernameTextField setKeyboardType:UIKeyboardTypeEmailAddress];
  [usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  [usernameTextField setBorderStyle:UITextBorderStyleBezel];
  [self setUsernameField:usernameTextField];
  [self.view addSubview:usernameTextField];
  
  UILabel *verified = [[UILabel alloc] initWithFrame:CGRectMake(200, 350, 280, 30)];
  [verified setText:@"Invalid Login"];
  [verified setHidden:YES];
  [self setVerifiedText:verified];
  [self.view addSubview:verified];
  
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.25];
  //self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y - 216);
  [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.25];
  //self.view.center = self.originalCenter;
  [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  NSLog(@"text field should return");
  NSInteger nextTag = textField.tag + 1;
  UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
  if (nextResponder) {
    [nextResponder becomeFirstResponder];
  } else {
    [textField resignFirstResponder];
    [self verifyUsernameWithSuccessBlock:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      NSDictionary *jsonResponse = (NSDictionary *)JSON;
      NSLog(@"returned json: %@", jsonResponse);
      [self usernameVerified:jsonResponse];
    } andFailBlock:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      NSDictionary *jsonResponse = (NSDictionary *)JSON;
      NSLog(@"error: %@", error);
      [self usernameNotVerified:jsonResponse];
    }];
  }
  return NO;
}

- (void)usernameVerified: (NSDictionary *)jsonResponse {
  if ([jsonResponse objectForKey:@"success"]) {
    [NUILabelRenderer render:self.verifiedText withClass:@"ConfirmText"];
    [self.verifiedText setText:@"Success! That username is available."];
    [self.verifiedText setHidden:NO];
    [self.verifiedText setAlpha:1];
  } else {
    [NUILabelRenderer render:self.verifiedText withClass:@"DenyText"];
    NSString *failText = [[jsonResponse objectForKey:@"error"] objectForKey:@"reason"];
    [self.verifiedText setText:failText];
    [self.verifiedText setHidden:NO];
    [self.verifiedText setAlpha:1];
  }
}

- (void)usernameNotVerified: (NSDictionary *)jsonResponse {
  [NUILabelRenderer render:self.verifiedText withClass:@"DenyText"];
  NSString *failText = [[jsonResponse objectForKey:@"error"] objectForKey:@"reason"];
  [self.verifiedText setText:failText];
  [self.verifiedText setHidden:NO];
  [self.verifiedText setAlpha:1];
}


- (void)verifyUsernameWithSuccessBlock:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))successBlock andFailBlock:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failBlock {
  NSLog(@"checking username");
  NSString *inputUsername = self.usernameField.text;
  NSLog(@"%@", inputUsername);
  NSDictionary *params = @{};
  if (inputUsername != nil) {
    params = @{@"username":inputUsername};
  } else {
    params = @{@"username":@""};
  }
  
  RKObjectManager *manager = [RKObjectManager sharedManager];
  AFHTTPClient *client = [manager HTTPClient];
  
  NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:@"account/check" parameters:params];
  
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.mode = MBProgressHUDModeIndeterminate;
  hud.labelText = @"Loading";
  
  AFJSONRequestOperation *checkUsername = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    [hud hide:YES];
    successBlock(request, response, JSON);
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [hud hide:YES];
    failBlock(request, response, error, JSON);
  }];
  
  [client enqueueHTTPRequestOperation:checkUsername];
}



- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
