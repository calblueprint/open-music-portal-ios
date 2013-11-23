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
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 300, 100)];
    nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.name];
    [self.view addSubview:nameLabel];
    
    /*
    startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 200, 300, 100)];
    nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.startTime];
    [self.view addSubview:nameLabel];
    
    endTimeLabel = []
    
    */
    
    /*
    //City label
    city_label = [[UILabel alloc] initWithFrame:CGRectMake(150 , 200,300 ,100)];
    city_label.text = [NSString stringWithFormat:@"City: %@", self.city];
    [self.view addSubview:city_label];
    
    //state label
    state_label = [[UILabel alloc] initWithFrame:CGRectMake(150 ,250 ,300 ,100)];
    state_label.text = [NSString stringWithFormat:@"State: %@", self.state];
    [self.view addSubview:state_label];
    
    //Country label
    country_label = [[UILabel alloc] initWithFrame:CGRectMake(150 , 300 ,300 ,100)];
    country_label.text = [NSString stringWithFormat:@"Country: %@", self.country];
    [self.view addSubview:country_label];
     */
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
