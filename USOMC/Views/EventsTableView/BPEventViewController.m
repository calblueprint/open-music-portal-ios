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

@implementation BPEventViewController
    

UILabel *nameLabel;
UILabel *roomLabel;

@synthesize name;
@synthesize eventId;
@synthesize roomNumber;
@synthesize contestants;
@synthesize judge;
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
    roomLabel =[[UILabel alloc] initWithFrame:CGRectMake(600, 150, 300, 100)];
    [roomLabel setNuiClass:@"roomLabel"];
    roomLabel.numberOfLines = 0;
    
    if (self.roomNumber == nil) {
        roomLabel.text = @"Room: Not Yet Assigned";
    } else {
        roomLabel.text = [NSString stringWithFormat:@"Room: %@", self.roomNumber];
    }
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
    [commentButton setNuiClass:@"eventPageButton"];
    [commentButton setBackgroundColor:[UIColor grayColor]];
    [commentButton setFrame:CGRectMake(130, 200, 300, 120)];
    [commentButton addTarget:self action:@selector(commentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [commentButton setTitle:@"Comment on Contestants" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:commentButton];
    
    UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rateButton setNuiClass:@"eventPageButton"];
    [rateButton setBackgroundColor:[UIColor grayColor]];
    [rateButton setFrame:CGRectMake(130, 350, 300, 120)];
    [rateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    //[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rateButton setTitle:@"Rank Contestants (1 judge only)" forState:UIControlStateNormal];
    [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rateButton];
    
    UIButton *rankingsButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rankingsButton setNuiClass:@"eventPageButton"];
    [rankingsButton setBackgroundColor:[UIColor grayColor]];
    [rankingsButton setFrame:CGRectMake(130, 500, 300, 120)];
    [rankingsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rankingsButton setTitle:@"View Contestant Rankings" forState:UIControlStateNormal];
    [rankingsButton addTarget:self action:@selector(viewRankings:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rankingsButton];

}

-(void)viewRankings: (id)selector {
    BPDisplayRankingsTableViewController *displayRankingsTableViewController = [[BPDisplayRankingsTableViewController alloc] init];
    [displayRankingsTableViewController setEventId:self.eventId];
    [displayRankingsTableViewController.view setBackgroundColor:[UIColor whiteColor]];
    [displayRankingsTableViewController setEventsNavigationController:self.eventsNavigationController];
    //[displayRankingsViewController loadRankings];
    [self.eventsNavigationController pushViewController:displayRankingsTableViewController animated:YES];
    
}



- (void)commentButtonPressed: (id)selector {
    BPDummyViewController *dummyViewController = [[BPDummyViewController alloc] init];
    NSLog(@"EventViewController commentButtonPressed eventID is: %d", (int)self.eventId);
    [dummyViewController setEventId:self.eventId];
    [dummyViewController setContestants:self.contestants];
    [dummyViewController setJudge:self.judge];
    [dummyViewController makeSplitView];
    [self.eventsNavigationController pushViewController:dummyViewController animated:YES];
}

- (void)rateButtonPressed: (id)selector {
  BPRatingsTableViewController *ratingsTableViewController = [[BPRatingsTableViewController alloc] init];
  [ratingsTableViewController setEventID:self.eventId];
  [ratingsTableViewController setJudge:self.judge];
  [ratingsTableViewController setContestants:self.contestants];
  [self.eventsNavigationController pushViewController:ratingsTableViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
