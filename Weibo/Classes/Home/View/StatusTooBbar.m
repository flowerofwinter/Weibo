//
//  StatusTooBbar.m
//  Weibo
//
//  Created by 宿莽 on 15/12/18.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "StatusTooBbar.h"

@implementation StatusTooBbar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage imageNamed:@"timeline_card_bottom_background_highlighted"];
        
        //添加按钮
        [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        //设置分割图片
        
    }
    return self;
}

-(void)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizeImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    //CGFloat btnY = self.frame.origin.y;
    CGFloat btnY = 0;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}
@end
