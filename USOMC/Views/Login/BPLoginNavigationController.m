//
//  BPLoginNavigationController.m
//
//
//  Created by William Tang on 11/14/13.
//
//

#import "BPLoginNavigationController.h"

@interface BPLoginNavigationController ()

@end

@implementation BPLoginNavigationController
@synthesize params = _params;
@synthesize eventsNavigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.params = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
