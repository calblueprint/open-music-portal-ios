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
UILabel *prevCommentsLabel;

@synthesize eventName;
@synthesize contestant;
@synthesize eventId;
@synthesize comments;
@synthesize judge;

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
    instructionLabel =[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 600, 600)];
    instructionLabel.numberOfLines = 0;
    [instructionLabel setBackgroundColor:[UIColor clearColor]];
    [instructionLabel setNuiClass:@"instructionLabel"];
  
    instructionLabel.text = @"Instructions: Select a contestant from the list at the left to begin making comments.";
    [self.view addSubview:instructionLabel];

}

- (void)makeLabels {
    NSLog(@"entering commentViewController makeLabels");
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 600, 100)];
    [nameLabel setNuiClass:@"commentNameLabel"];
    nameLabel.numberOfLines = 0;
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", contestant.firstName, contestant.lastName];
    nameLabel.text = firstLast;
    [self.view addSubview:nameLabel];
    prevCommentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 250, 600, 100)];
    [prevCommentsLabel setNuiClass:@"prevCommentsLabel"];
    prevCommentsLabel.text = @"Previous Comments:";
    [self.view addSubview:prevCommentsLabel];
}

- (void)makeCommentField {
    NSLog(@"entering commentViewController makeCommentField");
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 600, 150)];
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
    [submitButton setFrame:CGRectMake(500, 250, 180, 50)];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submitAction: (id)selector {
    NSLog(@"entering commentViewController submitAction");
    UIView *commentView = ((UIView *)selector).superview;
    NSString *commentsFromText = ((UITextField *)[commentView.subviews objectAtIndex:0]).text;
    NSLog(@"body of new comment is: %@", commentsFromText);
    //UNCOMMENT WHEN A REAL JUDGE IS PASSED IN
    NSNumber *judgeNum = self.judge.judgeId;
    //NSNumber *judgeNum = [NSNumber numberWithInt:8];
    NSNumber *contestantNum = self.contestant.contestantId;
    NSNumber *eventNum = [NSNumber numberWithInt:(int)self.eventId];
    NSLog(@"in CommentViewController submitAction eventNum is: %@", eventNum);
    NSDictionary *commentDict = @{@"judge":judgeNum, @"contestant":contestantNum, @"event":eventNum, @"body":commentsFromText};
    //UNCOMMENT WHEN A REAL JUDGE IS PASSED IN
    NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/%@/contestant/%d/comments", self.eventId,[self.judge.judgeId stringValue], [self.contestant.contestantId intValue]];
    //NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/8/contestant/%d/comment", (int)self.eventId, [self.contestant.contestantId intValue]];
    NSLog(@"Submit comment path is: %@", pathString);
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                    method:RKRequestMethodPOST
                                                                    path:pathString
                                                                    parameters:commentDict];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ BPComment.commentsResponseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"got comments");
        [self setComments:[mappingResult.dictionary objectForKey:@"comments"]];
        [self displayComments];
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
    NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/%@/contestant/%d/comments", self.eventId,[self.judge.judgeId stringValue], [self.contestant.contestantId intValue]];
    //NSString *pathString = [NSString stringWithFormat:@"events/%d/judge/8/contestant/%d/comments",(int)self.eventId, [self.contestant.contestantId intValue]];
    NSLog(@"CommentViewController loadExistingcomments pathString is : %@", pathString);
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] requestWithObject:nil
                                                                               method:RKRequestMethodGET
                                                                                 path:pathString
                                                                           parameters:nil];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[BPComment.commentsResponseDescriptor]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self setComments:[mappingResult.dictionary objectForKey:@"comments"]];
        NSLog(@"LOADED comments: %@", self.comments);
        [self displayComments];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: BPCommentViewController.loadExistingComments");
    }];
    NSLog(@"!!!!!self.comments: %@", self.comments);
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)displayComments {
    NSLog(@"entering commentViewController displayingComments");
    for(UIView * subView in self.view.subviews) {
        if([subView isKindOfClass:[UILabel class]]) // Check is SubView Class Is UILabel class
        {
            [subView removeFromSuperview];  // You can write code here for your UILabel;
        }
    }
    [self makeLabels];
    int yCoord = 300;
    for (BPComment *c in self.comments) {
        UILabel *commentLabel =[[UILabel alloc] initWithFrame:CGRectMake(40, yCoord, 600, 100)];
        commentLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        commentLabel.numberOfLines = 0;
        commentLabel.text = c.body;
        NSLog(@"comment body: %@", c.body);
        [self.view addSubview:commentLabel];
        yCoord += 30;
    }
}
@end
