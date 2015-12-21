//
//  Status.m
//  Weibo
//
//  Created by 宿莽 on 15/12/10.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "Status.h"

@implementation Status
-(NSString *)created_at{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];//日期格式化
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];//en是英文，zh是中文
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    //判断微博发送的时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
  //  NSString *str = [fmt stringFromDate:now];
   // NSLog(@"%@---%@---%@---%@",_created_at,createdDate,now,str);
    if ([calendar isDateInToday:createdDate]) {
        NSTimeInterval delta = [now timeIntervalSinceDate:createdDate];
        if (delta >= 3600) {
            return [NSString stringWithFormat:@"%d小时前",(int)(delta/3600)];//强制转换
        }else if(delta > 60){
            return [NSString stringWithFormat:@"%d分钟前",(int)(delta/60)];
        }else{
            //NSLog(@"%f",delta);
            return @"刚刚";
        }
    }else if([calendar isDateInYesterday:createdDate]){
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    }else if([calendar isDateInWeekend:createdDate]){
        fmt.dateFormat = @"本周 MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else{
        return @"很久";
    }
}

//-(NSString *)source{
//    NSLog(@"%@",_source);
//    int loc = [_source rangeOfString:@">"].location + 1;
//    int length = [_source rangeOfString:@"</a>"].location - loc;
//    if (loc>0&&length>0) {
//        NSString *newSource = [_source substringWithRange:NSMakeRange(loc, length)];
//        NSLog(@"%d",loc);
//        NSLog(@"%d",length);
//        return [NSString stringWithFormat:@"来自%@",newSource];
//    }else{
//        return nil;
//    }
//}
-(void)setSource:(NSString *)source{
    //NSLog(@"%@",source);
    int loc = [source rangeOfString:@">"].location + 1;
    //NSLog(@"%d",loc);
    int length = [source rangeOfString:@"</"].location - loc;
   // NSLog(@"%d",length);
    if (loc>0&&length>0) {
        NSString *newSource = [source substringWithRange:NSMakeRange(loc, length)];
        _source = [NSString stringWithFormat:@"来自%@",newSource];
    }else{
    }
}
@end
