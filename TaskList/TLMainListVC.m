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

@implementation TLMainListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"screenBackground.png"]];
    self.title = @"Task List";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row][@"desc"];

    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(16, 43, 280, 1)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    return cell;
}


@end
