//
//  ImageContainerView.m
//  Weibo
//
//  Created by 宿莽 on 15/12/25.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "ImageContainerView.h"
#import "ImageCell.h"
#define ImageCellH 70
#define ImageMargin 5

@implementation ImageContainerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<9; i++) {
            ImageCell *imageCell = [[ImageCell alloc]init];
            imageCell.userInteractionEnabled = YES;
            [self addSubview:imageCell];
        }
    }
    return self;
}

-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    for (int i = 0; i < self.subviews.count; i++) {
        ImageCell *imageCell = self.subviews[i];
        if (i < imageArr.count) {
            imageCell.hidden = NO;
            imageCell.statusImage = imageArr[i];
            
            int maxColumns = (imageArr.count == 4)?2:3;
            int col = i%maxColumns;
            int row = i/maxColumns;
            CGFloat imageCellX = col*(ImageCellH + ImageMargin);
            CGFloat imageCellY = row*(ImageCellH + ImageMargin);
            imageCell.frame = CGRectMake(imageCellX, imageCellY, ImageCellH, ImageCellH);
            if (imageArr.count == 1) {
                imageCell.contentMode = UIViewContentModeScaleAspectFit;
                imageCell.clipsToBounds = NO;
            }else{
                imageCell.contentMode = UIViewContentModeScaleAspectFill;
                imageCell.clipsToBounds = YES;
            }
        }else{
            imageCell.hidden = YES;
        }
    }
}

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
