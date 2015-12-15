//
//  Status.h
//  Weibo
//
//  Created by 宿莽 on 15/12/10.
//  Copyright © 2015年 宿莽. All rights reserved.
//  微博模型（一个status对象就是一条微博）

#import <Foundation/Foundation.h>
#import "WeiboUser.h"
@interface Status : NSObject
/**
 *  微博的内容
 */
@property(nonatomic,copy)NSString *text;
/**
 *  微博的来源
 */
@property(nonatomic,copy)NSString *source;
/**
 *  微博的ID
 */
@property(nonatomic,copy)NSString *idstr;
/**
 *  微博的转发数
 */
@property(nonatomic,assign)int reposts_count;
/**
 *  微博的评论数
 */
@property(nonatomic,assign)int comments_count;
/**
 *  微薄的作者
 */
@property(nonatomic,strong)WeiboUser *user;
/**
 *  微博配图
 */
@property(nonatomic,copy)NSString *thumbnail_pic;
/**
 *  微博发出时间
 */
@property(nonatomic,copy)NSString *created_at;
@end
