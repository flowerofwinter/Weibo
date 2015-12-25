//
//  ImageContainerView.m
//  Weibo
//
//  Created by 宿莽 on 15/12/25.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "ImageContainerView.h"
#define ImageCellH 70
#define ImageMargin 5

@implementation ImageContainerView

+(CGSize)ImageContainerViewSizeWithCount:(int)count{
    int maxColumn = (count == 4)?2:3; //忌用[]
    int row = (count + maxColumn -1)/maxColumn;
    //    int column = count%[(count == 4)?2:3];
    int column = (count >= maxColumn)?maxColumn:count;
    CGFloat imageH = ImageCellH * row +(row -1)*ImageMargin;
    CGFloat imageW = ImageCellH *column +(column - 1)*ImageMargin;
    return CGSizeMake(imageH, imageW);
}

@end
