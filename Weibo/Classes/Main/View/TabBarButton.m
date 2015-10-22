//
//  TabBarButton.m
//  Weibo
//
//  Created by 宿莽 on 15/10/15.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#define TabBarButtonImageRatio 0.6
#import "TabBarButton.h"
#import "BadgeButton.h"
//按钮的默认文字颜色
#define TabBarButtonTitleColor (iOS8?[UIColor blackColor]:[UIColor whiteColor])
//按钮的选中颜色
#define TabBarButtonTitleSelectedColor [UIColor orangeColor]

@interface TabBarButton()
/**
 *  提醒数字
 */
@property(nonatomic, weak)BadgeButton *badgeButton;
@end
@implementation TabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:TabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:TabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        if (!iOS8) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        //添加一个提醒的数字按钮
        BadgeButton *badgeButton = [[BadgeButton alloc]init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height*TabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height*TabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    //KVO监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  监听到某个对象的属性改变就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改了
 *  @param change  属性发生一些改变
 *  @param context 上下文环境
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    //设置提醒数字位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}
@end
