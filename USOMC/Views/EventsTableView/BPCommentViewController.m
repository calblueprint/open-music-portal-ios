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
@synthesize comments;
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
    NSLog(@"entering commentViewController viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)makeInstructionView {
    NSLog(@"entering commentViewController makeInstructionView");
    instructionLabel =[[UILabel alloc] initWithFrame:CGRectMake(50, 150, 600, 100)];
    instructionLabel.numberOfLines = 0;
    instructionLabel.text = @"Instructions: Select a Contestant from the list at the left to begin making comments.";
    [self.view addSubview:instructionLabel];

}

- (void)makeLabels {
    NSLog(@"entering commentViewController makeLabels");
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 600, 100)];
    nameLabel.numberOfLines = 0;
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", contestant.firstName, contestant.lastName];
    nameLabel.text = firstLast;
    [self.view addSubview:nameLabel];
}

- (void)makeCommentField {
    NSLog(@"entering commentViewController makeCommentField");
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
    [submitButton setFrame:CGRectMake(500, 350, 180, 50)];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submitAction: (id)selector {
    NSLog(@"entering commentViewController submitAction");
    UIView *commentView = ((UIView *)selector).superview;
    NSString *comments = ((UITextField *)[commentView.subviews objectAtIndex:0]).text;
    NSNumber *judgeNum = self.judge.judgeId;
    NSNumber *contestantNum = self.contestant.contestantId;
    NSNumber *eventNum = [NSNumber numberWithInt:self.eventId];
    NSLog(@"in CommentViewController submitAction eventNum is: %@", eventNum);
    NSDictionary *commentDict = @{@"judge":judgeNum, @"contestant":contestantNum, @"event":eventNum, @"body":comments};
    //UNCOMMENT WHEN A REAL JUDGE IS PASSED IN
    //NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/%d/contestant/%d/comment", self.eventId,[self.judge.judgeId intValue], [self.contestant.contestantId intValue]];
    NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/8/contestant/%d/comment", self.eventId, [self.contestant.contestantId intValue]];
    
    NSLog(@"comment post path is: %@", pathString);
    
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                    method:RKRequestMethodPOST
                                                                    path:pathString
                                                                    parameters:commentDict];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ BPComment.commentsResponseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self setComments:[mappingResult.dictionary objectForKey:@"comments"]];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: BPCommentViewController: submitAction");
    }];

    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)loadExistingComments {
    NSLog(@"entering commentViewController loadExistingComments");
    NSLog(@"Contestant in commentViewController: %@", contestant);
    NSLog(@"Contestant in commentViewController: %@", self.contestant);
    NSLog(@"CommentViewController contestantId is %d", [self.contestant.contestantId intValue]);
    //UNCOMMENT WHEN REAL JUDGE PASSED IN
    //NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/%d/contestant/%d/comment", self.eventId,[self.judge.judgeId intValue], [self.contestant.contestantId intValue]];
    NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/8/contestant/%d/comments",self.eventId, [self.contestant.contestantId intValue]];
    NSLog(@"CommentViewController loadExistingcomments pathString is : %@", pathString);
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                               method:RKRequestMethodGET
                                                                                 path:pathString
                                                                           parameters:nil];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[BPComment.commentsResponseDescriptor]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self setComments:[mappingResult.dictionary objectForKey:@"comments"]];
        NSLog(@"LOADED comments: %@", self.comments);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: BPCommentViewController.loadExistingComments");
    }];
    NSLog(@"!!!!!self.comments: %@", self.comments);
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)displayComments {
    NSLog(@"entering commentViewController displayingComments");
    int yCoord = 375;
    for (BPComment *c in self.comments) {
        UILabel *commentLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, yCoord, 600, 100)];
        instructionLabel.numberOfLines = 0;
        instructionLabel.text = c.body;
        [self.view addSubview:commentLabel];
        yCoord += 120;
    }
}
@end
