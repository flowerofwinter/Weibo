//
//  ComposeMuImages.h
//  Weibo
//
//  Created by 宿莽 on 16/2/28.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeMuImages : UIView
/**
 *  添加图片
 */
-(void)addImage:(UIImage *)image;

/**
 *  返回所有图片
 */
-(NSArray *)totalImages;
@end
