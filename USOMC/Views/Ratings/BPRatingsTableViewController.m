//
//  BPRatingsTableViewController.m
//  
//
//  Created by William Tang on 12/7/13.
//
//

#import "BPRatingsTableViewController.h"

@interface BPRatingsTableViewController ()

@end

@implementation BPRatingsTableViewController
@synthesize eventID;
@synthesize judge;
@synthesize contestants;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
