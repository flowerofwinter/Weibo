//
//  TabBar.m
//  Weibo
//
//  Created by 宿莽 on 15/10/15.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"
@interface TabBar()
@property(nonatomic, weak)TabBarButton *selectedBtn;
@end
@implementation TabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS8) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item{
    //1创建按钮
    TabBarButton *btn = [[TabBarButton alloc]init];
    [self addSubview:btn];
    //2设置数据
    btn.item = item;
/*
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
 */
    //3监听按钮反应
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //4默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self btnClick:btn];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width/self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    for (int index = 0; index < self.subviews.count; index++) {
        //1取出按钮
        TabBarButton *btn = self.subviews[index];
        //2设置按钮的frame
        CGFloat btnX = index*btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //3绑定tag
        btn.tag = index;
    }
}

-(void)btnClick:(TabBarButton *)btn{
    //1通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButton:to:)]) {
        [self.delegate tabBar:self didSelectedButton:self.selectedBtn.tag to:btn.tag];
    }
    //2设置按钮的状态
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}
@end
