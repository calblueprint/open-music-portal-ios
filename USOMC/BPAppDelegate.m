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
@synthesize eventTableViewController;

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
  [eventsTableViewController setEventsNavigationController:eventsNavigationController];
  
  // Login
  BPLoginViewController *loginViewController = [[BPLoginViewController alloc] init:eventsNavigationController];
  BPLoginNavigationController *loginNavController = [[BPLoginNavigationController alloc] initWithRootViewController:loginViewController];
  [self setLoginNavigationController:loginNavController];
  
  self.window.rootViewController = eventsNavigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

-(void)checkLogin {
  
  RKObjectManager *manager = [RKObjectManager sharedManager];
  KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainID" accessGroup:nil];
  [keychain setObject:@"USOMC" forKey:(__bridge id)kSecAttrService];
  
  NSUUID *vendorIdObject = [[UIDevice currentDevice] identifierForVendor];
  NSString *uuid = [vendorIdObject UUIDString];
  NSString *username = [keychain objectForKey:(__bridge id)kSecAttrAccount];
  NSString *password = [keychain objectForKey:(__bridge id)kSecValueData];
  NSDictionary *auth = @{@"app_id":uuid, @"username":username, @"password":password};
  
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
  hud.mode = MBProgressHUDModeIndeterminate;
  hud.labelText = @"Loading";
  
  NSMutableURLRequest *request = [manager requestWithObject:nil method:RKRequestMethodPOST path:@"start" parameters:auth];
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ BPJudge.judgesResponseDescriptor]];
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    NSLog(@"Succesfully logged in!");
    BPJudge *judge = [mappingResult.dictionary objectForKey:@"judge"];
    [self.eventTableViewController setJudge:judge];
    [hud hide:YES];
    
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Couldn't log in");
    [hud hide:YES];
  }];
  
  [manager enqueueObjectRequestOperation:objectRequestOperation];
  
  
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
  [self checkLogin];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
