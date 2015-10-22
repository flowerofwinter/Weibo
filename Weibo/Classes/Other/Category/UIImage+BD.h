//
//  UIImage+BD.h
//  Weibo
//
//  Created by 宿莽 on 15/10/15.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BD)
/**
 *  加载图片
 *
 *  @param name 图片名
 *
 *  @return 图片对象
 */
+(UIImage *)imageWithName:(NSString *)name;

+(UIImage *)resizeImageWithName:(NSString *)name;
@end
