//
//  NewFeatureVC.m
//  Weibo
//
//  Created by 宿莽 on 15/11/3.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "NewFeatureVC.h"
#import "TabBarViewController.h"
#define NewFeatureImageCount 3
@interface NewFeatureVC ()<UIScrollViewDelegate>
@property(nonatomic, weak)UIPageControl *pageControl;
@end
@implementation NewFeatureVC
-(void)viewDidLoad{
    [super viewDidLoad];
    //1.添加scrollView
    [self setupScrollView];
    //2.添加pagecontrol
    [self setupPageControl];
}
/**
 *  设置scrollView
 */
-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index<3; index++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        //设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        imageView.image = [UIImage imageWithName:name];
        //设置frame
        CGFloat imageX = index*imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        //在最后一个图片上面添加按钮
        if (index == NewFeatureImageCount - 1) {
            [self setupLastIageView:imageView];
        }
    }
    //3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW*NewFeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}
/**
 *  设置pagecontrol
 */
-(void)setupPageControl{
    //1、添加
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = NewFeatureImageCount;
    CGFloat centerX = self.view.frame.size.width*0.5;
    CGFloat centerY = self.view.frame.size.height-30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    //2、设置圆点的颜色
//    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
//    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.00f green:0.47f blue:0.16f alpha:1.00f];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.79f green:0.79f blue:0.79f alpha:1.00f];
}

/**
 *  只要scrollView滚动就会触发这个方法
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1.设置水平方向上的滚动距离
    CGFloat offset = scrollView.contentOffset.x;
    //2.求出页码
    double pageDouble = offset/scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}
/**
 *  给最后一张图片设置内容
 */
-(void)setupLastIageView:(UIImageView*)imageView{
    //0设置imageview可以交互
    imageView.userInteractionEnabled = YES;
    //1开始添加按钮
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //2设置frame
    CGFloat centerX = imageView.frame.size.width*0.5;
    CGFloat centerY = imageView.frame.size.height*0.85;
    startBtn.center = CGPointMake(centerX, centerY);
    startBtn.bounds = (CGRect){CGPointZero,startBtn.currentBackgroundImage.size};
    //3设置文字
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    //4添加checkbox
    UIButton *checkbox = [[UIButton alloc]init];
    [checkbox setTitle:@"分享" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = startBtn.bounds;
    CGFloat checkboxX = centerX;
    CGFloat checkboxY = imageView.frame.size.height*0.78;
    checkbox.center = CGPointMake(checkboxX, checkboxY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:checkbox];
}

-(void)checkboxClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
}

-(void)startBtnClick{
    TabBarViewController *tabbar = [[TabBarViewController alloc]init];
    //切换窗口的根控制器
    self.view.window.rootViewController = tabbar;
}
@end








