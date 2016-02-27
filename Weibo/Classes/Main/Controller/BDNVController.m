//
//  BDNVController.m
//  Weibo
//
//  Created by 宿莽 on 15/10/23.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "BDNVController.h"

@interface BDNVController ()

@end

@implementation BDNVController

/**
 *  只需设置一次的东西在这个函数里设置
 */
+(void)initialize{
    //1>设置导航栏的主题
    [self setupNavBarTheme];
    //2>设置导航栏Item的属性
    [self setupBarButtonItemTheme];
}
/**
 *  设置导航栏按钮的主题
 */
+(void)setupBarButtonItemTheme{
    //设置背景
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    if (!iOS8) {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    //设置文字属性
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName, nil] forState:UIControlStateDisabled];
}

/**
 *  设置导航栏主题的属性
 */
+ (void)setupNavBarTheme{
    //取出appearence对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置背景颜色
    if (!iOS8) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    //设置标题属性
    //    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    //    CGFloat a = 2.0;
    //    shadow.shadowBlurRadius = a;
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,shadow,NSShadowAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName, nil]];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
