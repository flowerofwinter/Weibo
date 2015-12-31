//
//  ImageCell.m
//  Weibo
//
//  Created by 宿莽 on 15/12/28.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "ImageCell.h"
#import "StatusImage.h"
#import "UIImageView+WebCache.h"
@interface ImageCell()

@property(nonatomic, weak)UIImageView *gifView;
@end@implementation ImageCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

-(void)setStatusImage:(StatusImage *)statusImage{
    _statusImage = statusImage;
    self.gifView.hidden = ![statusImage.thumbnail_pic hasPrefix:@"gif"];
    [self sd_setImageWithURL:[NSURL URLWithString:statusImage.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
