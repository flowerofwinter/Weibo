//
//  BDSearchBar.m
//  Weibo
//
//  Created by 宿莽 on 15/11/2.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "BDSearchBar.h"
@interface BDSearchBar()

@end
@implementation BDSearchBar
+(instancetype)searchBar{
    
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background"];
        //左边的放大镜
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        //字体
        self.font = [UIFont systemFontOfSize:13];
        
        //右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        //设置键盘右下角的按键样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置左边图标的位置
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    //设置提醒文字
    self.placeholder = @"搜索";   //设置在init里面会因为加载时间的先后导致placeholder与leftview重叠
}

@end
