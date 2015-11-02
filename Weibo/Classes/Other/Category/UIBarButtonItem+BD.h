//
//  UIBarButtonItem+BD.h
//  Weibo
//
//  Created by 宿莽 on 15/11/2.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BD)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon addTarget:(id)target action:(SEL)action;
@end
