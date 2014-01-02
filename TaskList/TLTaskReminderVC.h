//
//  TLTaskReminderVC.h
//  TaskList
//
//  Created by Kenneth on 12/26/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTaskReminderVC : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timeElapsedLabel;
@property (strong, nonatomic) IBOutlet UITextView *taskDesc;
@property (strong, nonatomic) IBOutlet UIButton *negativeBtn;
@property (strong, nonatomic) IBOutlet UIButton *positiveBtn;
@property (strong, nonatomic) IBOutlet UILabel *comments;
@property (strong, nonatomic) IBOutlet UIImageView *picture;

- (void) cancelAddComments;
- (void) confirmAddComments:(NSString *)comments;

- (IBAction)contactDONBtnTapped:(id)sender;
- (IBAction)confirmBtnTapped:(id)sender;
- (IBAction)rejectBtnTapped:(id)sender;
- (IBAction)addCommentsBtnTapped:(id)sender;
@end
