//
//  TabBar.h
//  Weibo
//
//  Created by 宿莽 on 15/10/15.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar;
@protocol TabBarDelegate<NSObject>
@optional
-(void)tabBar:(TabBar *)tabBar didSelectedButton:(int)from to:(int)to;
-(void)tabBarDidClickedPlusButton:(TabBar *)tabBar;
@end
@interface TabBar : UIView
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property(nonatomic, weak)id<TabBarDelegate> delegate;
@end
