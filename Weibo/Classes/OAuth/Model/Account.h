//
//  Account.h
//  Weibo
//
//  Created by 宿莽 on 15/12/9.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property(nonatomic,strong)NSString *access_token;
@property(nonatomic,strong)NSDate *expireTime;
@property(nonatomic,assign)long long expires_in;
@property(nonatomic,assign)long long remind_in;
@property(nonatomic,assign)long long uid;
/**
 *  用户的昵称
 */
@property(nonatomic,copy)NSString *name;
-(instancetype)initWIthDict:(NSDictionary *)dict;
+(instancetype)accountWithDict:(NSDictionary *)dict;


@end
