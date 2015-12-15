//
//  WeiboUser.h
//  Weibo
//
//  Created by 宿莽 on 15/12/10.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboUser : NSObject
/**
 *  用户的ID
 */
@property(nonatomic,copy)NSString *idstr;
/**
 *  用户的昵称
 */
@property(nonatomic,copy)NSString *name;
/**
 *  用户的头像
 */
@property(nonatomic,copy)NSString *profile_image_url;
/**
 *  是否是vip
 */
@property(nonatomic,assign,getter = isVip)BOOL vip;
@end
