//
//  TLAddCommentsVC.m
//  TaskList
//
//  Created by Kenneth on 12/26/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import "TLAddCommentsVC.h"

@interface TLAddCommentsVC ()

@end

@implementation TLAddCommentsVC

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
	// Do any additional setup after loading the view.
    if (self.isMandatory) {
        self.cancelBtn.hidden = YES;
        self.continueBtn.enabled = NO;
        self.comments.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueTapped:(id)sender
{
    [self.parentVC confirmAddComments:self.comments.text];
}

- (IBAction)cancelTapped:(id)sender
{
    [self.parentVC cancelAddComments];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
        self.continueBtn.enabled = YES;
}

@end
