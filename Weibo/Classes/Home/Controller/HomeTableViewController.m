//
//  HomeTableViewController.m
//  Weibo
//
//  Created by 宿莽 on 15/10/14.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIBarButtonItem+BD.h"
#import "TitleButton.h"

#define tBtnDowntag 0
#define tBtnUptag -1
@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = CGPointMake(100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" addTarget:self action:@selector(addFriend)];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" addTarget:self action:@selector(pop)];
    
    //中间按钮
    TitleButton *tbtn = [[TitleButton alloc]init];
    //设置图标
    [tbtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //设置文字
    [tbtn setTitle:@"点击" forState:UIControlStateNormal];
    //位置和尺寸
    tbtn.frame = CGRectMake(0, 0, 100, 30);
    [tbtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    tbtn.tag = tBtnDowntag;
    self.navigationItem.titleView = tbtn;
}

-(void)titleClick:(TitleButton *)button{
    if (button.tag == tBtnDowntag) {
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        button.tag = tBtnUptag;
    }else{
        [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        button.tag = tBtnDowntag;
    }
}

-(void)addFriend{
    IWLog(@"addFriend");
}

-(void)pop{
    IWLog(@"pop");
}

-(void)btnClick{
    self.tabBarItem.badgeValue = @"999";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //2设置cell的数据
    cell.textLabel.text = @"哈哈哈";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
