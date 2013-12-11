//
//  BPRatingsTableViewController.m
//  USOMC
//
//  Created by William Tang on 12/11/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPRatingsTableViewController.h"

@interface BPRatingsTableViewController ()
{
  NSIndexPath *currentCell;
}

@end

@implementation BPRatingsTableViewController
@synthesize eventID;
@synthesize judge;
@synthesize contestants;
@synthesize rankings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    myTable = [[HVTableView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) expandOnlyOneCell:YES enableAutoScroll:YES];
    myTable.HVTableViewDelegate = self;
    myTable.HVTableViewDataSource = self;
    //[myTable reloadData];
    [self.view addSubview:myTable];
    
    self.rankings = @{@"rankings": @[]};
    
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


//perform your expand stuff (may include animation) for cell here. It will be called when the user touches a cell
-(void)tableView:(UITableView *)tableView expandCell:(BPRatingsTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
  [[cell.contentView viewWithTag:11] removeFromSuperview];
  [[cell.contentView viewWithTag:12] removeFromSuperview];
  
  UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [rateButton setFrame:CGRectMake(450, 75, 120, 40)];
  [rateButton setAlpha:0];
  [rateButton setTitle:@"Rate Contestant" forState:UIControlStateNormal];
  [rateButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
  [rateButton setBackgroundColor:[UIColor grayColor]];
  [rateButton setTintColor:[UIColor whiteColor]];
  [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [cell.contentView addSubview:rateButton];
  rateButton.tag = 11;
  
  UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [commentsButton setFrame:CGRectMake(600, 75, 120, 40)];
  [commentsButton setAlpha:0];
  [commentsButton setTitle:@"View Comments" forState:UIControlStateNormal];
  [commentsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
  [commentsButton setBackgroundColor:[UIColor grayColor]];
  [commentsButton setTintColor:[UIColor whiteColor]];
  [commentsButton addTarget:self action:@selector(commentsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [cell.contentView addSubview:commentsButton];
  commentsButton.tag = 12;
  
  
  [UIView animateWithDuration:.5 animations:^{
    [rateButton setFrame:CGRectMake(450, 120, 120, 40)];
    [commentsButton setFrame:CGRectMake(600, 120, 120, 40)];
    [rateButton setAlpha:1];
    [commentsButton setAlpha:1];
    [cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(3.14);
    
  }];
}

//perform your collapse stuff (may include animation) for cell here. It will be called when the user touches an expanded cell so it gets collapsed or the table is in the expandOnlyOneCell satate and the user touches another item, So the last expanded item has to collapse
-(void)tableView:(UITableView *)tableView collapseCell:(BPRatingsTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
  [cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(0);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.contestants count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
  //you can define different heights for each cell. (then you probably have to calculate the height or e.g. read pre-calculated heights from an array
  if (isexpanded)
    return 200;
  
  return 100;
}

-(BPRatingsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
  static NSString *CellIdentifier = @"aCell";
  BPRatingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (!cell)
  {
    cell = [[BPRatingsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView* expandGlyph = [[UIImageView alloc] initWithFrame:CGRectMake(950, 45, 15, 10)];
    expandGlyph.image = [UIImage imageNamed:@"expandGlyph.png"];
    expandGlyph.tag = 7;
    [cell.contentView addSubview:expandGlyph];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.numberOfLines = 0;
    
    UILabel *ranking = [[UILabel alloc] initWithFrame:CGRectMake(450, 30, 270, 40)];
    [ranking.layer setBorderWidth:0.7];
    //[ratingLabel setBackgroundColor:[UIColor blueColor]];
    if (cell.rank == 0) {
      [ranking setText:@"No Ranking"];
    } else {
      [ranking setText:[NSString stringWithFormat:@"rank: %i", cell.rank]];
    }
    [ranking setTextAlignment:NSTextAlignmentCenter];
    
    [cell setLabel:ranking];
    [cell addSubview:ranking];
  }
  
  //alternative background colors for better division ;)
  if (indexPath.row %2 ==1)
    cell.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
  else
    cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];
  
  BPContestant *cell_contestant = [self.contestants objectAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", cell_contestant.firstName, cell_contestant.lastName];
  //cell.textLabel.text = [cellTitles objectAtIndex:indexPath.row % 10 ];
  cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", indexPath.row % 10 + 1]];
  
  
  if (!isExpanded) //prepare the cell as if it was collapsed! (without any animation!)
  {
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", cell.rank];
    [cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(0);
    
  }
  else ///prepare the cell as if it was expanded! (without any animation!)
  {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", cell.rank];
    [cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(3.14);
    
    [[cell.contentView viewWithTag:11] removeFromSuperview];
    [[cell.contentView viewWithTag:12] removeFromSuperview];
    
    
  }
  return cell;
}

//===== Other Methods ===============================================

- (void)rateButtonPressed: (id)selector {
  NSLog(@"Rate Button Pressed");
  CGPoint buttonPosition = [selector convertPoint:CGPointZero toView:myTable];
  NSIndexPath *indexPath = [myTable indexPathForRowAtPoint:buttonPosition];
  currentCell = indexPath;
  BPRatingsTableViewCell *cell = (BPRatingsTableViewCell*)[myTable cellForRowAtIndexPath:indexPath];
  
  
  BPContestant *contestant = [self.contestants objectAtIndex:indexPath.row];
  NSLog(@"contestant: %@", contestant);
  
  UIColor *whiteColor = [UIColor colorWithRed:0.816 green:0.788 blue:0.788 alpha:1.000];
  UIView *popup = [[UIView alloc] initWithFrame:CGRectMake(300, 100, 400, 250)];
  
  popup.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8f];
  popup.layer.borderColor = whiteColor.CGColor;
  popup.layer.borderWidth = 2.f;
  popup.layer.cornerRadius = 10.f;
  
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 250, 30)];
  titleLabel.text = cell.textLabel.text;
  titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.f];
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.shadowColor = [UIColor blackColor];
  titleLabel.shadowOffset = CGSizeMake(0, -1);
  titleLabel.textAlignment = NSTextAlignmentLeft;
  titleLabel.backgroundColor = [UIColor clearColor];
  [popup addSubview:titleLabel];
  
  UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 50, 380, 100)];
  myPickerView.delegate = (id)self;
  myPickerView.showsSelectionIndicator = YES;
  [myPickerView setBackgroundColor:[UIColor whiteColor]];
  
  
  [popup addSubview:myPickerView];
  
  RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self view:popup];
  [modal show];
}

- (void)commentsButtonPressed: (id)selector {
  NSLog(@"comments button pressed");
}

- (void)doneButtonPressed: (id)selector {
  NSLog(@"Done Button Pressed");
}

//========= UIPickerView Logic ===========================================
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
  // Handle the selection
  NSLog(@"current cell: %@", currentCell);
  BPRatingsTableViewCell *cell = (BPRatingsTableViewCell*)[myTable cellForRowAtIndexPath:currentCell];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", row];
  [cell setRank:row];
  
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return 11;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  NSString *title;
  title = [@"" stringByAppendingFormat:@"%d",row];
  
  return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  int sectionWidth = 300;
  
  return sectionWidth;
}



@end