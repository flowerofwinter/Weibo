//
//  AccountTool.m
//  Weibo
//
//  Created by 宿莽 on 15/12/9.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "AccountTool.h"
#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"Account.data"]
@implementation AccountTool

+(Account *)Account{
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];
    NSDate *now = [NSDate date];
    if ([now compare:account.expireTime] == NSOrderedAscending) {
        return account;
    }else{
        return nil;
    }
}

+(void)saveAccount:(Account *)account{
    NSDate *now = [NSDate date];
    account.expireTime = [now dateByAddingTimeInterval:account.expires_in];
   // NSLog(@"有效期是%@",account.expireTime);
    NSLog(@"有效期是%lld,截止到%@",account.expires_in,account.expireTime);//类型不匹配会导致后面的不能输出
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFile];
}
@end
