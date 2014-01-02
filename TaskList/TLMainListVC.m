//
//  TLViewController.m
//  TaskList
//
//  Created by Kenneth on 12/4/13.
//  Copyright (c) 2013 OpsViz. All rights reserved.
//

#import "TLMainListVC.h"

@interface TLMainListVC ()

@end

@implementation TLMainListVC {
    NSMutableArray *_recipes;
    NSTimeInterval _startTime;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Master list";
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tasklistTableView addGestureRecognizer:gesture];
    
    _recipes = [NSMutableArray arrayWithArray: [NSArray arrayWithObjects:
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
                                                @"Did you observe any change in the individual's physical condition?",
                                                @"Did you observe any change in the individual's emotional condition?",
                                                @"Was there any change in the individual's regular daily activities?",
                                                @"Do you have an observation about the individual's response to services rendered?",
                                                nil]];
    _startTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_recipes count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    float level = (100+20*(indexPath.row % 2))/255.0;
    cell.backgroundColor = [UIColor colorWithRed:level green:level blue:level alpha:1.0];
    cell.textLabel.text = [_recipes objectAtIndex:indexPath.row];
    return cell;
}


-(void)didSwipe:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint swipeLocation = [gestureRecognizer locationInView:self.tasklistTableView];
        NSIndexPath *swipedIndexPath = [self.tasklistTableView indexPathForRowAtPoint:swipeLocation];
        [_recipes removeObjectAtIndex:swipedIndexPath.row];
        
        NSArray *deleteIndexPaths = [[NSArray alloc] initWithObjects:
                                     swipedIndexPath,
                                     nil];
        [self.tasklistTableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
}
@end
