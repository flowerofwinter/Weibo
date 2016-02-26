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
#import "MJRefresh.h"
#define tBtnDowntag 0
#define tBtnUptag -1
@interface HomeTableViewController ()
@property(nonatomic,strong)NSMutableArray *statusFrame;
@property(nonatomic, weak)UIButton *topBtn;
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
    //获取用户信息
    [self getUserInfo];
}

-(void)setupRefreshView{
    //上拉刷新
    /* 系统自带刷新控件
    UIRefreshControl *RefreshControl = [[UIRefreshControl alloc]init];
    //监听刷新控件的状态是否改变了
    [RefreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:RefreshControl];
    //自动刷新不会触发监听事件
    [RefreshControl beginRefreshing];
    [self refreshControlStateChange:RefreshControl];
    */
    [self headerRefresh];
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self headerRefresh];
    }];
    //下拉刷新
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [self footerRefresh];
    }];
}

-(void)getUserInfo{
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool Account].access_token;
    params[@"uid"] = @([AccountTool Account].uid);//不注意就错了，数字不是对象
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WeiboUser *usr = [WeiboUser objectWithKeyValues:responseObject];
        [self.topBtn setTitle:usr.name forState:UIControlStateNormal];
        //保存账号昵称
        Account *account = [AccountTool Account];
        account.name = usr.name;
        [AccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)headerRefresh{
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
       // [refreshControl endRefreshing];
        [self.tableView.mj_header endRefreshing];
        //界面友好，给用户以提示，刷新的效果
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)footerRefresh{
    //发送请求，取得之前的数据
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool Account].access_token;
    params[@"count"] = @5;
    if (self.statusFrame.count) {
        CellFrame *cellFrame = [self.statusFrame lastObject];
        long long maxID = [cellFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(maxID);
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *statusArray = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (Status *status in statusArray) {
            CellFrame *cellframe = [[CellFrame alloc]init]; //强制类型转换
            cellframe.status = status;
            [statusFrameArray addObject:cellframe];
        }
        //添加到旧数据后面
        [self.statusFrame addObjectsFromArray:statusFrameArray];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

/**
 *  显示刷新出来的微博的数量
 *
 *  @param count 新微博的数量
 */
-(void)showNewStatusCount:(int)count{
    //1.创建按钮
    UIButton *btn = [[UIButton alloc]init];
    //belowSubview涨姿势
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizeImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新微博" forState:UIControlStateNormal];
    }
    //设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = self.view.frame.size.width;
    CGFloat btnX = 0;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    //通过动画向下移动btnH+1的距离
    [UIView animateWithDuration:1.0 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH+1);
    }completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:1.0 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{//执行返回的动画(清空transform)
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {//将btn从内存中移除
            [btn removeFromSuperview]; //不清空亦可。因为是局部变量
//            btn = nil;  block当中是不能对外部的变量修改的
        }];
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
    //位置和尺寸(必须放在设置文字之前，因为宽度是零，下面的重写的settitle方法可以根据文字计算宽度)
    tbtn.frame = CGRectMake(0, 0, 0, 30);
    //设置文字
    if ([AccountTool Account].name) {
        [tbtn setTitle:[AccountTool Account].name forState:UIControlStateNormal];
    }else{
      [tbtn setTitle:@"点击" forState:UIControlStateNormal];
    }
    
    [tbtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    tbtn.tag = tBtnDowntag;
    self.navigationItem.titleView = tbtn;
    self.topBtn = tbtn;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CellWidth, 0);
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
