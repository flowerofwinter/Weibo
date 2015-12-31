//
//  ImageContainerView.h
//  Weibo
//
//  Created by 宿莽 on 15/12/25.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageContainerView : UIView
/**
 *  图片数组URL
 */
@property(nonatomic,strong)NSArray *imageArr;
/**
 *  输入图片的个数，返回所需View的大小
 */
+(CGSize)ImageContainerViewSizeWithCount:(int)count;
@end
