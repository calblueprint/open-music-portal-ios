//
//  BPAppDelegate.m
//  USOMC
//
//  Created by Mark Miyashita on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPAppDelegate.h"
#import "NUIAppearance.h"


@implementation BPAppDelegate
@synthesize loginNavigationController;
@synthesize homeViewController;
@synthesize loginViewController;
@synthesize judge;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  //let AFNetworking manage the activity indicator
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
  // Initialize HTTPClients
  NSURL *localURL = [NSURL URLWithString:@"http://localhost:3000/api/v1/"];
  AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:localURL];
  
  [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
  
  //Initialize RestKit RKObjectManager
  RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
  [RKObjectManager setSharedManager:objectManager];
  
  [NUIAppearance init];
  
  BPEventsTableViewController *eventsTableViewController = [[BPEventsTableViewController alloc] init];
  BPEventsNavigationController *eventsNavigationController = [[BPEventsNavigationController alloc] initWithRootViewController:eventsTableViewController];
  UIBarButtonItem *butt = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logout:)];
  eventsTableViewController.navigationItem.rightBarButtonItem = butt;
  [eventsTableViewController setEventsNavigationController:eventsNavigationController];
  [self setHomeViewController:eventsNavigationController];
  
  // Login
  self.loginViewController = [[BPLoginViewController alloc] init:eventsNavigationController];
  self.loginNavigationController = [[BPLoginNavigationController alloc] initWithRootViewController:self.loginViewController];
  
  
  self.window.rootViewController = eventsNavigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

-(void)checkLogin {
  RKObjectManager *manager = [RKObjectManager sharedManager];
  AFHTTPClient *client = [manager HTTPClient];
  NSDictionary *params = [self.loginViewController keychainCredentials];

  KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainID" accessGroup:nil];
  [keychain setObject:@"USOMC" forKey:(__bridge id)kSecAttrService];
  
  NSString *username = [keychain objectForKey:(__bridge id)kSecAttrAccount];
  NSString *password = [keychain objectForKey:(__bridge id)kSecValueData];
  NSDictionary *auth = @{@"email":username, @"password":password};

  NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:@"login" parameters:params];
  AFJSONRequestOperation *checkCredentials = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    NSDictionary *jsonResponse = (NSDictionary*)JSON;
    if ([jsonResponse objectForKey:@"judge"]) {
      NSLog(@"JsonResponse: %@", jsonResponse);
      NSDictionary *judgeJson = [jsonResponse objectForKey:@"judge"];
      //NSLog(@"JUDGE: %@", judgeJson);
      self.judge = [[BPJudge alloc] init];
      /*
       SET JUDGE'S INFO
       */
    } else{
      [self.homeViewController presentViewController:self.loginNavigationController animated:YES completion:nil];
    }
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    NSLog(@"Failed to login with keychain credentials");
  }];
  
  [client enqueueHTTPRequestOperation:checkCredentials];
}

-(void)logout: (id)selector {
  NSLog(@"logout button pressed");
  //clear keychain
  [self.loginViewController clearKeychain];
  //display login controller
  [self.homeViewController presentViewController:self.loginNavigationController animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  //[self.homeViewController presentViewController:self.loginNavigationController animated:NO completion:nil];
  if (!self.homeViewController.presentedViewController) {
    [self checkLogin];
  }

  
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
