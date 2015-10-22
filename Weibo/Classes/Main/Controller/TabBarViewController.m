//
//  TabBarViewController.m
//  
//
//  Created by 宿莽 on 15/10/14.
//
//

#import "TabBarViewController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoverTableViewController.h"
#import "MeTableViewController.h"
#import "UIImage+BD.h"
#import "TabBar.h"
@interface TabBarViewController ()<TabBarDelegate>
@property(nonatomic,weak)TabBar *customTabbar;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabbar
    [self setupTabbar];
    //初始化所有子控制器
    [self setupAllChildViewController];
}

/**
 *  初始化所有子控制器代码
 */
-(void)setupAllChildViewController{
   
    HomeTableViewController *home = [[HomeTableViewController alloc]init];
    home.tabBarItem.badgeValue = @"100";
 //   home.view.backgroundColor = [UIColor redColor];
    [self setupChildViewCotroller:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    /*
     home.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected_os7"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     home.title = @"首页";
     //    home.tabBarItem.title = @"首页";
     //    home.navigationItem.title = @"首页";
     home.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_os7"];
     UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:home];
     [self addChildViewController:homeNav];
     */
    MessageTableViewController *message = [[MessageTableViewController alloc]init];
    message.tabBarItem.badgeValue = @"10";
 //   message.view.backgroundColor = [UIColor redColor];
    [self setupChildViewCotroller:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    /*
     message.tabBarItem.title = @"消息";
     message.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_selected_os7"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     message.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center_os7"];
     [self addChildViewController:message];
     */
    DiscoverTableViewController *discover = [[DiscoverTableViewController alloc]init];
    discover.tabBarItem.badgeValue = @"12";
 //   discover.view.backgroundColor = [UIColor redColor];
    [self setupChildViewCotroller:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    /*
     discover.tabBarItem.title = @"广场";
     discover.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected_os7"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     discover.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover_os7"];
     [self addChildViewController:discover];
     */
    MeTableViewController *me = [[MeTableViewController alloc]init];
    me.tabBarItem.badgeValue = @"2";
//    me.view.backgroundColor = [UIColor redColor];
    [self setupChildViewCotroller:me title:@"自己" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    /*
     me.tabBarItem.title = @"自己";
     me.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected_os7"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     me.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile_os7"];
     [self addChildViewController:me];
     */
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         tabbaritem的图片
 *  @param selectedImageName 选中的图片
 */
-(void)setupChildViewCotroller:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    //包装一个导航控制器
    UINavigationController *childNav = [[UINavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:childNav];
    //3>添加tabbar内部的按钮
    [self.customTabbar addTabBarButtonWithItem:childVc.tabBarItem];
}

-(void)setupTabbar{
    TabBar *customTabbar = [[TabBar alloc]init];
    customTabbar.delegate = self;
    customTabbar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabbar];
    self.customTabbar = customTabbar;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

-(void)tabBar:(TabBar *)tabBar didSelectedButton:(int)from to:(int)to{
    self.selectedIndex = to;
}
@end
