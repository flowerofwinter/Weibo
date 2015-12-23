//
//  RetweetStatusView.m
//  Weibo
//
//  Created by 宿莽 on 15/12/22.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "RetweetStatusView.h"

#import "StatusImage.h"
#import "UIImageView+WebCache.h"
@interface RetweetStatusView ()
/**
 *  被转发作者的昵称
 */
@property(nonatomic, weak)UILabel *retweetLable;
/**
 *  被转发的内容
 */
@property(nonatomic, weak)UILabel *retweetStatus;
/**
 *  被转发的微博图片
 */
@property(nonatomic, weak)UIImageView *retweetImage;
@end
@implementation RetweetStatusView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        //1.昵称
        UILabel *retweetLable = [[UILabel alloc]init];
        retweetLable.font = [UIFont systemFontOfSize:14];
        retweetLable.backgroundColor = [UIColor clearColor];
        retweetLable.textColor = [UIColor colorWithRed:0.37f green:0.64f blue:0.98f alpha:1.00f];
        [self addSubview:retweetLable];
        self.retweetLable = retweetLable;
        
        //2.正文内容
        UILabel *retweetStatus = [[UILabel alloc]init];
        retweetStatus.numberOfLines = 0; //换行
        retweetStatus.font = [UIFont systemFontOfSize:13];
        retweetStatus.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetStatus];
        self.retweetStatus = retweetStatus;
        
        //3.配图
        UIImageView *retweetImage = [[UIImageView alloc]init];
        [self addSubview:retweetImage];
        self.retweetImage = retweetImage;
    }
    return self;
}

-(void)setRetweetData:(CellFrame *)retweetData{
    _retweetData = retweetData;  //set方法第一行就是这个，要不没数据
    Status *retweetedstatus = retweetData.status.retweeted_status;
    WeiboUser *user = retweetedstatus.user;
    //1.昵称
    self.retweetLable.text = [NSString stringWithFormat:@"@%@",user.name];
    self.retweetLable.frame = self.retweetData.retweetLableFrame;
    //2.正文
    self.retweetStatus.text = retweetedstatus.text;
    self.retweetStatus.frame = self.retweetData.retweetStatusFrame;
    //3.配图
    if (retweetedstatus.pic_urls.count) {
        self.retweetImage.hidden = NO;
        StatusImage *simage = retweetedstatus.pic_urls.firstObject;
        [self.retweetImage sd_setImageWithURL:[NSURL URLWithString:simage.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"app"]];
        self.retweetImage.frame = self.retweetData.retweetImageFrame;
    }else{
        self.retweetImage.hidden = YES;
    }
}
@end
