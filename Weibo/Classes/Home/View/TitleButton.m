//
//  TitleButton.m
//  Weibo
//
//  Created by 宿莽 on 15/11/3.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "TitleButton.h"
#define imagew 20
@implementation TitleButton
+(instancetype)titleButton{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //高亮的时候不能自动调整图片
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        //背景
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = imagew;
    CGFloat imageY = 0;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = contentRect.size.width - imagew;
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    NSDictionary * attributes = @{NSFontAttributeName: self.titleLabel.font}; //
    CGFloat titleW = [title sizeWithAttributes:attributes].width;
    CGRect frame = self.frame;
    frame.size.width = titleW + imagew +5;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}

@end
