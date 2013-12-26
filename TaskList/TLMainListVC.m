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
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tasklistTableView addGestureRecognizer:gesture];
    
    _recipes = [NSMutableArray arrayWithArray: [NSArray arrayWithObjects:@"Prepare fresh nutritious meals", @"Remind to stay hydrated", @"Observe dietary special needs", @"Vacuum and dust", @"Clean kitchen", @"Clean and sanitize bathrooms", @"Organize closets and cabinets", @"Change the linen", @"Laundry: Wash, dry, fold, put away", @"Assistance with bath or shower", @"Feeding", @"Oral Care: Teeth brushing, denture care", @"Hair washing, drying, combing and brushing", @"Make-up application", @"Nail care", @"Toileting: bedside commode or bathroom", nil]];
    
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
    
    float level = (100+10*indexPath.row)/255.0;
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
