//
//  UIImage+BD.m
//  Weibo
//
//  Created by 宿莽 on 15/10/15.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "UIImage+BD.h"

@implementation UIImage (BD)
+(UIImage *)imageWithName:(NSString *)name{
    if (iOS8){
        NSString *newNmae = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newNmae];//过了一会儿才报错，并且进程很长，考虑是否是死循环
        if (image == nil) {//没有os7后缀
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    return [UIImage imageNamed:name];
}

+(UIImage *)resizeImageWithName:(NSString *)name{
    return [self resizeImageWithName:name left:0.5 top:0.5];
}

+(UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}
@end
