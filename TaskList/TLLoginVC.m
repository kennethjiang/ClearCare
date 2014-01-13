//
//  TLLoginVC.m
//  TaskList
//
//  Created by Kenneth on 12/25/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import "TLLoginVC.h"
#import "TLTaskReminderVC.h"

@interface TLLoginVC ()

@end

@implementation TLLoginVC

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
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"screenBackground.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginBtnTapped:(id)sender
{
    PFObject *logEntry = [PFObject objectWithClassName:@"LogEntry"];
    logEntry[@"desc"] = @"Checked in";
    [logEntry saveInBackground];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"LoginToReminderVC"])
	{
		TLTaskReminderVC *vc = segue.destinationViewController;
        [vc refreshTaskList];
	}
}
@end
