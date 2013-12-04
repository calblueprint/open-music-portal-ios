//
//  BPCommentViewController.m
//  USOMC
//
//  Created by Allison Leong on 11/27/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPCommentViewController.h"

@interface BPCommentViewController ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation BPCommentViewController
UILabel *instructionLabel;
UILabel *nameLabel;

@synthesize eventName;
@synthesize contestant;
@synthesize eventId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:eventName];
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
- (void)makeInstructionView {
    instructionLabel =[[UILabel alloc] initWithFrame:CGRectMake(50, 150, 600, 100)];
    instructionLabel.numberOfLines = 0;
    instructionLabel.text = @"Instructions: Select a Contestant from the list at the left to begin making comments.";
    [self.view addSubview:instructionLabel];

}

- (void)makeLabels {
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 600, 100)];
    nameLabel.numberOfLines = 0;
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", contestant.firstName, contestant.lastName];
    nameLabel.text = firstLast;
    [self.view addSubview:nameLabel];
}

- (void)makeCommentField {
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, 600, 150)];
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.placeholder = @"Type Comments Here";
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [self.view addSubview:self.textField];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton setTitle:@"Submit!" forState:UIControlStateNormal];
    //[submitButton setNuiClass:@"Button:LargeButton"];
    [submitButton setFrame:CGRectMake(70, 260, 180, 50)];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submitAction: (id)selector {
    UIView *commentView = ((UIView *)selector).superview;
    NSString *comments = ((UITextField *)[commentView.subviews objectAtIndex:0]).text;
    NSDictionary *commentDict = @{@"body": comments};
    NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/%d/contestant/%d/comment", self.eventId,self.judge.judgeId, self.contestant.userId];
    
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil method:RKRequestMethodPOST path:pathString parameters:commentDict];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ DTUser.responseDescriptor ]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
/*

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // add your method here
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
 */

@end
