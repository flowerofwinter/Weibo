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
#import "CellFrame.h"
#import "StatusCell.h"
#import "StatusImage.h"
#define tBtnDowntag 0
#define tBtnUptag -1
@interface HomeTableViewController ()
@property(nonatomic,strong)NSMutableArray *statusFrame;
@end

@implementation HomeTableViewController

-(NSMutableArray *)statusFrame{
    if (_statusFrame == nil) {
        _statusFrame = [NSMutableArray array];
    }return _statusFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshView];
    //设置导航栏
    [self setupNavBar];
    //加载微博数据
//    [self setupStatusData];
}

-(void)setupRefreshView{
    UIRefreshControl *RefreshControl = [[UIRefreshControl alloc]init];
    //监听刷新控件的状态是否改变了
    [RefreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:RefreshControl];
    //自动刷新不会触发监听事件
    [RefreshControl beginRefreshing];
    [self refreshControlStateChange:RefreshControl];
}

-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl{
//    NSLog(@"说明了状态已经发生改变");
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool Account].access_token;
    params[@"count"] = @5;
    if (self.statusFrame.count) {
        CellFrame *cellframe = self.statusFrame[0];
        //要加载ID比sinceID还大的
        params[@"since_id"] = cellframe.status.idstr;
    }
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSMutableArray *statusArray = [NSMutableArray array];
        //        for (NSDictionary *dict in dictArray) {
        //            Status *status = [Status objectWithKeyValues:dict];
        //            [statusArray addObject:status];
        //        }
        //        self.statuses = statusArray;
        
        //        NSArray *dictArray = responseObject[@"statuses"];
        //        self.statuses = [Status objectArrayWithKeyValuesArray:dictArray];
        NSArray *statusArray = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (Status *status in statusArray) {
            CellFrame *cellFrame = [[CellFrame alloc]init];
            cellFrame.status = status;
            [statusFrameArray addObject:cellFrame];
        }
        //将最新的数据追加到旧数据的最前面
        //旧数据:self.statusFrames
        //新数据:statusFrameArray
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrame];
        self.statusFrame = tempArray;
        [self.tableView reloadData];
        //转轮停止刷新
        [refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [refreshControl endRefreshing];
    }];
}

-(void)setupNavBar{
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.center = CGPointMake(100, 100);
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
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
    
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CellWidth, 0);
    self.tableView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//cell分割线隐藏
}
/*
-(void)setupStatusData{
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool Account].access_token;
    //params[@"count"] = @5;  //请求个数的参数没注意竟然被屏蔽了，不过没有影响，默认的是20条；
    //发送请求

    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            Status *status = [Status objectWithKeyValues:dict];
//            [statusArray addObject:status];
//        }
//        self.statuses = statusArray;
        
//        NSArray *dictArray = responseObject[@"statuses"];
//        self.statuses = [Status objectArrayWithKeyValuesArray:dictArray];
        NSArray *statusArray = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (Status *status in statusArray) {
            CellFrame *cellFrame = [[CellFrame alloc]init];
            cellFrame.status = status;
            [statusFrameArray addObject:cellFrame];
        }
        self.statusFrame = statusFrameArray;
        [self.tableView reloadData];
//        for (Status *status in statusArray) {
//            NSLog(@"%@",[[status.pic_urls lastObject] class]);
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}
*/
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
    return self.statusFrame.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1创建cell
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    //2.传递frame模型
    cell.cellFrame = self.statusFrame[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellFrame *cellFrame = self.statusFrame[indexPath.row];
    return cellFrame.cellHeight;
}




@end
