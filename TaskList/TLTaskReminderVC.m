//
//  TLTaskReminderVC.m
//  TaskList
//
//  Created by Kenneth on 12/26/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import "TLTaskReminderVC.h"
#import "TLAddCommentsVC.h"

@interface TLTaskReminderVC () {
    NSMutableArray *_taskList;
    NSMutableArray *_questionList;
    NSTimeInterval _startTime;

    int _currentIdx;
    BOOL _allTasksDone;
    BOOL _allQuestionsDone;
    BOOL _transitioningToNextTask;
}

@end

@implementation TLTaskReminderVC

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
    
    _taskList = [NSMutableArray arrayWithArray: [NSArray arrayWithObjects:
                                                 @"Complete/partial bath",
                                                 @"Dress/undress",
                                                 @"Assist with toileting",
                                                 @"Transferring",
                                                 @"Personal grooming",
                                                 @"Assist with eating/feeding",
                                                 @"Ambulation",
                                                 @"Turn/Change position",
                                                 @"Vital Signs",
                                                 @"Assist with self-administration medication",
                                                 @"Bowel/bladder",
                                                 @"Wound care",
                                                 @"ROM",
                                                 @"Supervision",
                                                 @"Prepare breakfast",
                                                 @"Prepare lunch",
                                                 @"Prepare dinner",
                                                 @"Clean kitchen/wash dishes",
                                                 @"Make/change bed linen",
                                                 @"Clean areas used by individual",
                                                 @"Listing supplies/shopping",
                                                 nil]];
    _questionList = [NSMutableArray arrayWithArray: [NSArray arrayWithObjects:
        @"Did you observe any change in the individual's physical condition?",
        @"Did you observe any change in the individual's emotional condition?",
        @"Was there any change in the individual's regular daily activities?",
        @"Do you have an observation about the individual's response to services rendered?",
        nil]];
    
    _currentIdx = 0;
    _transitioningToNextTask = NO;
    _allTasksDone = NO;
    _allQuestionsDone = NO;
    
    _taskDesc.text = [_taskList objectAtIndex:_currentIdx];
    _taskDesc.font = [UIFont boldSystemFontOfSize:24.0];
    _taskDesc.textAlignment = NSTextAlignmentCenter;
    _startTime = [NSDate timeIntervalSinceReferenceDate];
    [self updateTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - _startTime;
    
    int hours = (int) (elapsed/3600.0);
    elapsed -= 3600.0 * hours;
    int mins = (int) (elapsed/60.0);
    elapsed -= 60.0 * mins;
    int secs = (int) (elapsed);
    
    self.timeElapsedLabel.text = [NSString stringWithFormat:@"%02u:%02u:%02u", hours, mins, secs];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

- (void)contactDONBtnTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Call", @"Text", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)confirmBtnTapped:(id)sender
{
    [self nextTask];
}

- (IBAction)rejectBtnTapped:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TLAddCommentsVC *vc = (TLAddCommentsVC *) [sb instantiateViewControllerWithIdentifier:@"addCommentsVC"];
    vc.parentVC = self;
    vc.isMandatory = YES;
    vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:vc animated:YES completion:NULL];
    
    _transitioningToNextTask = YES;
    
}


- (IBAction)addCommentsBtnTapped:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TLAddCommentsVC *vc = (TLAddCommentsVC *) [sb instantiateViewControllerWithIdentifier:@"addCommentsVC"];
    vc.parentVC = self;
    vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) cancelAddComments
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) confirmAddComments:(NSString *)comments
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.comments.text = comments;
    
    if (_transitioningToNextTask)
        [self nextTask];
    
}

- (void) nextTask
{
    if (! _allTasksDone)
    {
        _taskDesc.text = [_taskList objectAtIndex:++_currentIdx];

        if (_currentIdx >= (_taskList.count - 1))
        {
            _allTasksDone = YES;
            _currentIdx = -1;
        }
    }
    else if (! _allQuestionsDone) //Task list is over. We are at questions now
    {
        if (_currentIdx == -1) {
            [self.negativeBtn setTitle:@"Yes" forState:UIControlStateNormal];
            [self.positiveBtn setTitle:@"No" forState:UIControlStateNormal];
        }
        _taskDesc.text = [_questionList objectAtIndex:++_currentIdx];
        if (_currentIdx >= (_questionList.count -1))
        {
            _allQuestionsDone = YES;
        }
    }
    else
    {
        
    }
    _taskDesc.font = [UIFont boldSystemFontOfSize:24.0];
    _taskDesc.textAlignment = NSTextAlignmentCenter;
    _comments.text = @"No comments";
    _transitioningToNextTask = NO;
}

@end
