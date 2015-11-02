//
//  UIBarButtonItem+BD.m
//  Weibo
//
//  Created by 宿莽 on 15/11/2.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "UIBarButtonItem+BD.h"

@implementation UIBarButtonItem (BD)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon addTarget:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    btn.frame = (CGRect){CGPointZero,btn.currentBackgroundImage.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
