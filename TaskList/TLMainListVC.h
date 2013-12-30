//
//  TLViewController.h
//  TaskList
//
//  Created by Kenneth on 12/4/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLMainListVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tasklistTableView;
@property (strong, nonatomic) IBOutlet UILabel *timeElapsedLabel;

- (IBAction)contactDONBtnTapped:(id)sender;

@end
