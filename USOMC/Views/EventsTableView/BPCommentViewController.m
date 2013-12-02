//
//  BPCommentViewController.m
//  USOMC
//
//  Created by Allison Leong on 11/27/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPCommentViewController.h"

@interface BPCommentViewController ()


@end

@implementation BPCommentViewController
UILabel *instructionLabel;

@synthesize eventName;

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

- (void)makeCommentField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"Type Comments Here";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //textField.delegate = self;
    [self.view addSubview:textField];
}

@end
