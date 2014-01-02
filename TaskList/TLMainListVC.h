//
//  TLViewController.h
//  TaskList
//
//  Created by Kenneth on 12/4/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLMainListVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tasklistTableView;

@end
