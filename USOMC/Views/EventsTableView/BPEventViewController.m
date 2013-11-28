//
//  BPEventViewController.m
//  USOMC
//
//  Created by Allison Leong on 11/9/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPEventViewController.h"

@interface BPEventViewController ()

@end

@implementation BPEventViewController {
    

UILabel *nameLabel;
UILabel *roomLabel;
//UILabel *roomNumberLabel;
//UITableView *contestantListTable;
//UITableView *judgeTable;
//UILabel *startTimeLabel;
//UILabel *endTimeLabel;
    
}

@synthesize name;
//@synthesize roomNumber;
//@synthesize contestantList;
//@synthesize judgeList;
//@synthesize startTime;
//@synthesize endTime;
@synthesize eventsNavigationController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:name];
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)makeLabels {
    //User name label
    //nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 300, 100)];
    //nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.name];
    //[self.view addSubview:nameLabel];
    
    roomLabel =[[UILabel alloc] initWithFrame:CGRectMake(150, 150, 300, 100)];
    roomLabel.text = @"Room: 150";
    [self.view addSubview:roomLabel];
    
    /*
    startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 200, 300, 100)];
    nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.startTime];
    [self.view addSubview:nameLabel];
    
    endTimeLabel = []
    
    */
    
    
}
- (void)makeButtons {
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commentButton setBackgroundColor:[UIColor grayColor]];
    [commentButton setFrame:CGRectMake(150, 300, 300, 100)];
    [commentButton addTarget:self action:@selector(commentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [commentButton setTitle:@"Comment on a Contestant" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:commentButton];
    
    UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rateButton setBackgroundColor:[UIColor grayColor]];
    [rateButton setFrame:CGRectMake(150, 450, 300, 100)];
    [rateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    //[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rateButton setTitle:@"Rate the Contestants (1 judge only)" forState:UIControlStateNormal];
    [self.view addSubview:rateButton];
}



- (void)commentButtonPressed: (id)selector {
    NSLog(@"commentButtonPressed!");
    BPDummyViewController *dummyViewController = [[BPDummyViewController alloc] init];
    [dummyViewController makeSplitView];
    [self.eventsNavigationController pushViewController:dummyViewController animated:YES];
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
