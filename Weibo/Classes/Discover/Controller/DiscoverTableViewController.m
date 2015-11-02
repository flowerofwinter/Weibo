//
//  DiscoverTableViewController.m
//  Weibo
//
//  Created by 宿莽 on 15/10/14.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "BDSearchBar.h"
@interface DiscoverTableViewController ()

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BDSearchBar *search = [BDSearchBar searchBar];
    search.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = search;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
