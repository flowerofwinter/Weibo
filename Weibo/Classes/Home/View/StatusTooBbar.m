//
//  StatusTooBbar.m
//  Weibo
//
//  Created by 宿莽 on 15/12/18.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "StatusTooBbar.h"
@interface StatusTooBbar()
@property(nonatomic,strong)NSMutableArray *btnCounts;
@property(nonatomic,strong)NSMutableArray *dividerCounts;
@end
@implementation StatusTooBbar

-(NSMutableArray *)btnCounts{
    if (_btnCounts == nil) {
        _btnCounts = [NSMutableArray array];
    }
    return _btnCounts;
}

-(NSMutableArray *)dividerCounts{
    if (_dividerCounts == nil) {
        _dividerCounts = [NSMutableArray array];
    }
    return _dividerCounts;
}

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
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

-(void)setupDivider{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividerCounts addObject:divider];
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
    [self.btnCounts addObject:btn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat divW = 2;
    CGFloat btnW = (self.frame.size.width - self.dividerCounts.count*divW)/ self.btnCounts.count;
    CGFloat btnH = self.frame.size.height;
    //CGFloat btnY = self.frame.origin.y;
    CGFloat btnY = 0;
    for (int i = 0; i<self.btnCounts.count; i++) {
        UIButton *btn = self.btnCounts[i];
        CGFloat btnX = i*(btnW +divW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    CGFloat divH = btnH;
   
    CGFloat divY = 0;
    for (int j = 0; j<self.dividerCounts.count; j++) {
        UIButton *btn = self.btnCounts[j];
        UIImageView *divider = self.dividerCounts[j];
        //CGFloat divX = (j + 1)*btnW;
        CGFloat divX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(divX, divY, divW, divH);
    }
}
@end

