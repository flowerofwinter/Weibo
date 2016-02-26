//
//  ImageContainerView.m
//  Weibo
//
//  Created by 宿莽 on 15/12/25.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "ImageContainerView.h"
#import "ImageCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "StatusImage.h"


@implementation ImageContainerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<9; i++) {
            ImageCell *imageCell = [[ImageCell alloc]init];
            imageCell.userInteractionEnabled = YES;
            imageCell.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
            [imageCell addGestureRecognizer:tap];
            [self addSubview:imageCell];
        }
    }
    return self;
}

-(void)imageTap:(UITapGestureRecognizer *)recognizer{
    int count = self.imageArr.count;
    //1.封装图片
    NSMutableArray *myImages = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        MJPhoto *mjphoto = [[MJPhoto alloc]init];
        mjphoto.srcImageView = self.subviews[i];
        StatusImage *statusimage = [[StatusImage alloc]init];
        NSString *photoURL = [statusimage.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoURL];
        [myImages addObject:mjphoto];
    }
    //2.显示图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex = recognizer.view.tag;
    browser.photos = myImages;
    [browser show];
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
