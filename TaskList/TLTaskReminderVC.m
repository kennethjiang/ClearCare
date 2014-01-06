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
    NSArray *_taskList;
    NSTimeInterval _startTime;
    PFObject *_logEntry;

    int _currentIdx;
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

    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(listBtnTapped:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    _startTime = [NSDate timeIntervalSinceReferenceDate];
    [self updateTime];
    
}

- (void)viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    [query whereKey:@"assigned" equalTo:@"T"];
    [query orderByAscending:@"position"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (!error) {
            [self taskListRefreshed:tasks];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void) taskListRefreshed:(NSArray *)tasks {
    _taskList = tasks;
    
    _currentIdx = -1;
    _transitioningToNextTask = NO;
    _logEntry = nil;
    
    [self nextTask];
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

- (void)listBtnTapped:(id)sender
{
    [self performSegueWithIdentifier:@"toMainList" sender:self];
}

- (IBAction)confirmBtnTapped:(id)sender
{
    PFObject *task = [_taskList objectAtIndex:_currentIdx];
    _logEntry[@"status"] = ([task[@"isQuestion"] isEqualToString:@"T"])? @"No" : @"Confirmed";
    [self nextTask];
}

- (IBAction)rejectBtnTapped:(id)sender
{
    PFObject *task = [_taskList objectAtIndex:_currentIdx];
    _logEntry[@"status"] = ([task[@"isQuestion"] isEqualToString:@"T"])? @"Yes" : @"Rejected";
    
    if (_logEntry[@"comments"]) {
        [self nextTask];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TLAddCommentsVC *vc = (TLAddCommentsVC *) [sb instantiateViewControllerWithIdentifier:@"addCommentsVC"];
        vc.parentVC = self;
        vc.isMandatory = YES;
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:NULL];
        
        _transitioningToNextTask = YES;
    }
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
    _logEntry[@"comments"] = comments;
    
    if (_transitioningToNextTask)
        [self nextTask];
    
}

- (void) nextTask
{

    if (_logEntry) {
        [_logEntry saveInBackground];
    }
    
    if (++_currentIdx < _taskList.count) {
        PFObject *task = [_taskList objectAtIndex:_currentIdx];
        _taskDesc.text = task[@"desc"];

        if (task[@"pic"]) {
            self.picture.hidden = NO;
            PFFile *picFile = task[@"pic"];
            [picFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                if (!error) {
                    [self.picture setImage:[UIImage imageWithData:imageData]];
                }
            }];
        }
        else {
            self.picture.hidden = YES;
        }
        
        if ([task[@"isQuestion"] isEqualToString:@"T"]) {
            [self.negativeBtn setTitle:@"Yes" forState:UIControlStateNormal];
            [self.positiveBtn setTitle:@"No" forState:UIControlStateNormal];
        } else {
            [self.negativeBtn setTitle:@"Reject" forState:UIControlStateNormal];
            [self.positiveBtn setTitle:@"Confirm" forState:UIControlStateNormal];
        }
        
        _taskDesc.font = [UIFont boldSystemFontOfSize:24.0];
        _taskDesc.textAlignment = NSTextAlignmentCenter;
        _comments.text = @"No comments";
        _transitioningToNextTask = NO;
    
        _logEntry = [PFObject objectWithClassName:@"LogEntry"];
        _logEntry[@"desc"] = [_taskList objectAtIndex:_currentIdx][@"desc"];
    }
}

@end
