//
//  ComposeMuImages.m
//  Weibo
//
//  Created by 宿莽 on 16/2/28.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import "ComposeMuImages.h"

@implementation ComposeMuImages


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

-(void)addImage:(UIImage *)image{
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = image;
    [self addSubview:imageview];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat imageviewW = 70;
    CGFloat imageviewH = 70;
    int maxColumns = 4;
    CGFloat margin = (self.frame.size.width - maxColumns*imageviewW)/(maxColumns+1);
    for (int i = 0; i<count; i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageviewX = margin + (i % maxColumns)*(imageviewW + margin);
        CGFloat imageviewY = (i / maxColumns)*(imageviewH + margin);
        imageView.frame = CGRectMake(imageviewX, imageviewY, imageviewW, imageviewH);
    }
}

-(NSArray *)totalImages{
    NSMutableArray *images = [NSMutableArray array];
//    for (int i = 0; i<images.count; i++) {
//        [images addObject:<#(nonnull id)#>]
//    }错误思想
    for (UIImageView *imageview in self.subviews) {
        [images addObject:imageview.image];
    }
    return images;
}

@end
