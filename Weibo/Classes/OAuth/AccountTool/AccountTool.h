//
//  AccountTool.h
//  Weibo
//
//  Created by 宿莽 on 15/12/9.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
@interface AccountTool : NSObject
+(Account *)Account;
+(void)saveAccount:(Account *)account;
@end
