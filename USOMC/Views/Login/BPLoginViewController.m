//
//  BPLoginViewController.m
//  USOMC
//
//  Created by William Tang on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPLoginViewController.h"

@interface BPLoginViewController () {
  NSString *email;
  NSString *password;
  Boolean *success;
}
@end

@implementation BPLoginViewController
@synthesize verifiedText = _verfifiedText;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;
@synthesize eventsNavigationController = _eventsNavigationController;
@synthesize eventsTableViewController;
@synthesize keychain;

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
  UIImage *background = [UIImage imageNamed:@"piano.png"];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
  [self.view addSubview:imageView];
  
  UITextField *usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(372, 330, 280, 30)];
  [usernameTextField setPlaceholder:@"Email"];
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
  
  UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(372, 390, 280, 30)];
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
  
  
  UILabel *verified = [[UILabel alloc] initWithFrame:CGRectMake(372, 450, 400, 30)];
  [verified setText:@"Invalid Login"];
  [verified setHidden:YES];
  [verified setTextColor:[UIColor redColor]];
  [self setVerifiedText:verified];
  [self.view addSubview:verified];
  
  //Check Keychain email + password first
  
  NSLog(@"Checking Keychain credentials first.");
  self.keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainID" accessGroup:nil];
  [keychain setObject:@"USOMC" forKey:(__bridge id)kSecAttrService];
  email = [keychain objectForKey:(__bridge id)kSecAttrAccount];
  password = [keychain objectForKey:(__bridge id)kSecValueData];

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
    //NSLog(@"self.usernameField.text: %@", self.usernameField.text);
    //NSLog(@"self.passwordField.text: %@", self.passwordField.text);
    email = self.usernameField.text;
    password = self.passwordField.text;
    [self.keychain setObject:email forKey:(__bridge id)kSecAttrAccount];
    [self.keychain setObject:password forKey:(__bridge id)kSecValueData];
    
    //verify credentials
    NSLog(@"Checking Text Field Entered Credentials.");
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
  NSLog(@"email: %@", email);
  NSLog(@"password: %@", password);
  NSString *encryptedEmail = [AESCrypt encrypt:email password:PUBLICKEY];
  NSString *encryptedPassword = [AESCrypt encrypt:password password:PUBLICKEY];

  NSDictionary *params = @{};
  //if (self.usernameField.text != nil && self.passwordField.text != nil) {
  if (encryptedEmail != nil && encryptedPassword != nil) {
    params = @{@"email":encryptedEmail, @"password":encryptedPassword};
    //NSLog(@"Credentials all here");
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
  NSLog(@"Entered credentialsVerified");
  if ([jsonResponse objectForKey:@"judge"]) {
    //[NUILabelRenderer render:self.verifiedText withClass:@"ConfirmText"];
    //[self.verifiedText setText:@"Success! Credentials are valid."];
    //[self.verifiedText setHidden:NO];
    //[self.verifiedText setAlpha:1];
    NSDictionary *judgeJson = [jsonResponse objectForKey:@"judge"];
    [self.verifiedText setHidden:YES];
    BPJudge *judge = [[BPJudge alloc] init];
    [judge setFirstName:[judgeJson objectForKey:@"first_name"]];
    [judge setLastName:[judgeJson objectForKey:@"last_name"]];
    [judge setJudgeId:[judgeJson objectForKey:@"encid"]];
    [self.eventsTableViewController setJudge:judge];
    //NSLog(@"judge's first name: %@", self.eventsTableViewController.judge.firstName);
    
    [self.eventsNavigationController dismissViewControllerAnimated:YES completion:nil];
  } else {
    [NUILabelRenderer render:self.verifiedText withClass:@"DenyText"];
    [self.verifiedText setText:@"LOGIN FAILED. PLEASE TRY AGAIN"];
    [self.verifiedText setHidden:NO];
    [self.verifiedText setAlpha:1];
  }
}

-(void)credentialsNotVerified: (NSDictionary *)jsonResponse {
  NSLog(@"Entered credentialsNotVerified");
  [NUILabelRenderer render:self.verifiedText withClass:@"DenyText"];
  [self.verifiedText setText:@"LOGIN FAILED. PLEASE TRY AGAIN"];
  [self.verifiedText setHidden:NO];
  [self.verifiedText setAlpha:1];

}

-(NSDictionary*)keychainCredentials {
  self.keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainID" accessGroup:nil];
  email = [self.keychain objectForKey:(__bridge id)kSecAttrAccount];
  password = [self.keychain objectForKey:(__bridge id)kSecValueData];
  NSString *encryptedEmail = [AESCrypt encrypt:email password:PUBLICKEY];
  NSString *encryptedPassword = [AESCrypt encrypt:password password:PUBLICKEY];
  
  NSDictionary *params = @{@"email":encryptedEmail, @"password":encryptedPassword};
  return params;
}

-(void)clearKeychain {
  [self.keychain setObject:@"" forKey:(__bridge id)kSecAttrAccount];
  [self.keychain setObject:@"" forKey:(__bridge id)kSecValueData];
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
