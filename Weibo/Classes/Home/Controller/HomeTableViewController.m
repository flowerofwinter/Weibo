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
#import "Account.h"
#import "AccountTool.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Status.h"
#import "WeiboUser.h"
#import "MJExtension.h"
#define tBtnDowntag 0
#define tBtnUptag -1
@interface HomeTableViewController ()
@property(nonatomic,strong)NSArray *statuses;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavBar];
    //加载微博数据
    [self setupStatusData];
}

-(void)setupNavBar{
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

-(void)setupStatusData{
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool Account].access_token;
    //params[@"count"] = @2;
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            Status *status = [Status objectWithKeyValues:dict];
//            [statusArray addObject:status];
//        }
//        self.statuses = statusArray;
        self.statuses = [Status objectArrayWithKeyValuesArray:dictArray];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //2设置cell的数据
    Status *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    //微博作者的昵称
    cell.detailTextLabel.text = status.user.name;
    
    //微博作者的头像
    NSString *iconuser = status.user.profile_image_url;
    [cell.imageView setImageWithURL:[NSURL URLWithString:iconuser] placeholderImage:[UIImage imageWithName:@"icon.png"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
