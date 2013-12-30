//
//  TLAddCommentsVC.h
//  TaskList
//
//  Created by Kenneth on 12/26/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTaskReminderVC.h"

@interface TLAddCommentsVC : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) TLTaskReminderVC *parentVC;
@property BOOL isMandatory;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *continueBtn;
@property (strong, nonatomic) IBOutlet UITextView *comments;

- (IBAction)continueTapped:(id)sender;
- (IBAction)cancelTapped:(id)sender;

@end
