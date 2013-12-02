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
@synthesize passwordField = _passwordField;
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
  [usernameTextField setTag:998];
  [usernameTextField setDelegate:(id) self];
  [usernameTextField setKeyboardType:UIKeyboardTypeEmailAddress];
  [usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  [usernameTextField setBorderStyle:UITextBorderStyleRoundedRect];
  [usernameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
  [usernameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
  [self setUsernameField:usernameTextField];
  [self.view addSubview:usernameTextField];
  
  UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(200, 350, 280, 30)];
  [passwordTextField setPlaceholder:@"Password"];
  [passwordTextField setReturnKeyType:UIReturnKeyDone];
  [passwordTextField setTag:999];
  [passwordTextField setDelegate:(id) self];
  [passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  [passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
  [passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
  [passwordTextField setSecureTextEntry:YES];
  [passwordTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
  [self setPasswordField:passwordTextField];
  [self.view addSubview:passwordTextField];
  
  
  UILabel *verified = [[UILabel alloc] initWithFrame:CGRectMake(200, 400, 280, 30)];
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

- (BOOL)textFieldDidEndEditing:(UITextField *)textField {
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.25];
  //self.view.center = self.originalCenter;
  [UIView commitAnimations];
  return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  //Remove keyboard when touch other part of screen
  NSLog(@"touchesBegan:withEvent:");
  [self.view endEditing:YES];
  [super touchesBegan:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  NSLog(@"textField should return");
  NSInteger nextTag = textField.tag + 1;
  UIResponder *nextResponder = [textField.superview viewWithTag:nextTag]; //If done editing username textfield, switch to password
  if (nextResponder) {
    [nextResponder becomeFirstResponder];
  } else {
    [textField resignFirstResponder]; //if done editing password, resign first responder status
    NSLog(@"self.usernameField.text: %@", self.usernameField.text);
    NSLog(@"self.passwordField.text: %@", self.passwordField.text);
    
    //verify credentials
    [self verifyCredentialsWithSuccessBlock:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      NSDictionary *jsonResponse = (NSDictionary *)JSON;
      NSLog(@"success: returned json: %@", jsonResponse);
      //Credentials are valid
      [self credentialsVerified:jsonResponse];
    } andFailBlock:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      NSDictionary *jsonResponse = (NSDictionary *)JSON;
      NSLog(@"failure: returned json: %@", jsonResponse);
      //Credentials are invalid
      [self credentialsNotVerified:jsonResponse];
    }];
  }
  return NO;
}

-(void)verifyCredentialsWithSuccessBlock:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))successBlock andFailBlock:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failBlock {
  NSLog(@"Checking username and password");
  NSString *inputUsername = self.usernameField.text;
  NSString *inputPassword = self.passwordField.text;
  NSDictionary *params = @{};
  if (self.usernameField.text != nil && self.passwordField.text != nil) {
    params = @{@"email":inputUsername, @"password":inputPassword};
    NSLog(@"Credentials all here");
  } else {
    NSLog(@"Missing Credentials");
    params = @{@"email":@"", @"password":@""};
  }
  NSLog(@"PARAMS: %@", params);
  
  //Make api calls
  RKObjectManager *manager = [RKObjectManager sharedManager];
  AFHTTPClient *client = [manager HTTPClient];
  
  NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:@"login" parameters:params];
  
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.mode = MBProgressHUDModeIndeterminate;
  hud.labelText = @"Loading";
  
  AFJSONRequestOperation *checkCredentials = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    [hud hide:YES];
    successBlock(request, response, JSON);
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [hud hide:YES];
    failBlock(request, response, error, JSON);
  }];
  
  [client enqueueHTTPRequestOperation:checkCredentials];
}

-(void)credentialsVerified: (NSDictionary *)jsonResponse {
  if ([jsonResponse objectForKey:@"success"]) {
    [NUILabelRenderer render:self.verifiedText withClass:@"ConfirmText"];
    [self.verifiedText setText:@"Success! Credentials are valid."];
    [self.verifiedText setHidden:NO];
    [self.verifiedText setAlpha:1];
    [self.eventsNavigationController dismissViewControllerAnimated:YES completion:nil];
  } else {
    [NUILabelRenderer render:self.verifiedText withClass:@"DenyText"];
    NSString *failText = [[jsonResponse objectForKey:@"error"] objectForKey:@"reason"];
    [self.verifiedText setText:failText];
    [self.verifiedText setHidden:NO];
    [self.verifiedText setAlpha:1];
  }
}

-(void)credentialsNotVerified: (NSDictionary *)jsonResponse {
  [NUILabelRenderer render:self.verifiedText withClass:@"DenyText"];
  NSString *failText = [[jsonResponse objectForKey:@"error"] objectForKey:@"reason"];
  [self.verifiedText setText:failText];
  [self.verifiedText setHidden:NO];
  [self.verifiedText setAlpha:1];

}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
