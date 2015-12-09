//
//  WeiboTool.m
//  Weibo
//
//  Created by 宿莽 on 15/12/9.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "WeiboTool.h"
#import "TabBarViewController.h"
#import "NewFeatureVC.h"
@implementation WeiboTool
+(void)chooseRootController{
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarViewController alloc]init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NewFeatureVC alloc]init];
    }
}
@end
