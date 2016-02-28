//
//  ComposeToolBar.m
//  Weibo
//
//  Created by 宿莽 on 16/2/28.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import "ComposeToolBar.h"

@implementation ComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:ComposeToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:ComposeToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:ComposeToolBarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:ComposeToolBarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:ComposeToolBarButtonTypeEmotion];
    }
    return self;
}

-(void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag{
    UIButton *button = [[UIButton alloc]init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

-(void)buttonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:button.tag];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}
@end
