//
//  MessageTableViewController.m
//  Weibo
//
//  Created by 宿莽 on 15/10/14.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "MessageTableViewController.h"

@interface MessageTableViewController ()

@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:nil action:nil];
  //  self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}



@end
