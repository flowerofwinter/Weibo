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
@property(nonatomic, weak)UIButton *plusBtn;
@property(nonatomic,strong)NSMutableArray *tabBarBtns;
@end
@implementation TabBar

-(NSMutableArray *)tabBarBtns{
    if (_tabBarBtns == nil) {
        _tabBarBtns = [NSMutableArray array];
    }
    return _tabBarBtns;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS8) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        //添加一个加号的按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusBtn = plusButton;
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
    //5添加按钮到数组中
    [self.tabBarBtns addObject:btn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusBtn.center = CGPointMake(w*0.5, h*0.5);
    
    CGFloat btnW = self.frame.size.width/self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    for (int index = 0; index < self.tabBarBtns.count; index++) {
        //1取出按钮
        TabBarButton *btn = self.tabBarBtns[index];
        //2设置按钮的frame
        CGFloat btnX = index*btnW;
        if (index > 1) {
            btnX += btnW;
        }
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
