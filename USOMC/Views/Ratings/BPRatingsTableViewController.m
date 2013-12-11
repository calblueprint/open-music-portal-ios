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
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)];
  self.navigationItem.rightBarButtonItem = doneButton;
}

#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  // If you're serving data from an array, return the length of the array:
  return [self.contestants count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self rateContestant:indexPath];
  }

- (BPRatingsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"cellIdD";
  BPRatingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[BPRatingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setRank:0];
    
  }
  BPContestant *cell_contestant = [self.contestants objectAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", cell_contestant.firstName, cell_contestant.lastName];
  
  UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(750, 6, 100, 30)];
  //[ratingLabel.layer setBorderColor:[UIColor blueColor].CGColor];
  [ratingLabel.layer setBorderWidth:3.0];
  //[ratingLabel setBackgroundColor:[UIColor blueColor]];
  if (cell.rank == 0) {
    [ratingLabel setText:@"None"];
  } else {
    [ratingLabel setText:[NSString stringWithFormat:@"rank: %i", cell.rank]];
  }
  [cell addSubview:ratingLabel];
  
  return cell;
}


#pragma mark UIPickerView Delegate

#pragma mark Other Methods

- (void)doneButtonPressed: (id)selector {
  NSLog(@"hey");
  //Submit rankings to server
}


- (void)rateContestant:(NSIndexPath *)indexPath {
  BPRatingsTableViewCell *cell = (BPRatingsTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
  [cell setRank:15];
  
  UIColor *whiteColor = [UIColor colorWithRed:0.816 green:0.788 blue:0.788 alpha:1.000];
  
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(300, 100, 400, 400)];
  
  view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8f];
  view.layer.borderColor = whiteColor.CGColor;
  view.layer.borderWidth = 2.f;
  view.layer.cornerRadius = 10.f;
  
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 250, 30)];
  titleLabel.text = cell.textLabel.text;
  titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.f];
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.shadowColor = [UIColor blackColor];
  titleLabel.shadowOffset = CGSizeMake(0, -1);
  titleLabel.textAlignment = NSTextAlignmentLeft;
  titleLabel.backgroundColor = [UIColor clearColor];
  [view addSubview:titleLabel];
  
  UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [rateButton setFrame:CGRectMake(100, 100, 150, 50)];
  [rateButton setBackgroundColor:[UIColor whiteColor]];
  [rateButton setTitle:@"Rate Contestant" forState:UIControlStateNormal];
  [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [view addSubview:rateButton];
  
  UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [commentsButton setFrame:CGRectMake(100, 200, 150, 50)];
  [commentsButton setBackgroundColor:[UIColor whiteColor]];
  [commentsButton addTarget:self action:@selector(commentsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [commentsButton setTitle:@"View Comments" forState:UIControlStateNormal];
  [view addSubview:commentsButton];
  
  view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  
  RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self view:view];
  [modal show];

  //[cell.textLabel setText:[NSString stringWithFormat:@"new rank: %i", cell.rank]];
}

- (void)rateButtonPressed: (id)selector {
  NSLog(@"Rate Button Pressed");
  
}

- (void)commentsButtonPressed: (id)selector {
  NSLog(@"Comments Button Pressed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
