//

//  CellFrame.m

//  Weibo

//

//  Created by 宿莽 on 15/12/16.

//  Copyright © 2015年 宿莽. All rights reserved.

//



#import "CellFrame.h"

#import "Status.h"



@implementation CellFrame



-(void)setStatus:(Status *)status{
    
    _status = status;
    
    //topViewFrame
    
    CGFloat topViewW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat topViewH = 0;
    
    CGFloat topViewX = 0;
    
    CGFloat topViewY = 0;
    
    //头像
    
    CGFloat iconViewXY = CellBorder;
    
    CGFloat iconViewWH = 35;
    
    _iconViewFrame = CGRectMake(iconViewXY, iconViewXY, iconViewWH, iconViewWH);
    
    //昵称
    
    CGFloat nameLabelX = iconViewXY + iconViewWH;
    
    CGFloat nameLabelY = iconViewXY;
    
    //   CGFloat FontHeight = 25;
    
    //  NSDictionary *FontDict =@{NSFontAttributeName:[UIFont systemFontOfSize:25]};//对于字体属性的设置
    
    CGSize nameSize = [status.user.name sizeWithAttributes:StatusNameFont];//sizeWithAttributes方法的使用
    
    _nameLableFrame = (CGRect){{nameLabelX,nameLabelY},nameSize};//另类写法
    
    //是否是会员
    
    if (status.user.isVip) {
        
        CGFloat vipX = CGRectGetMaxX(_nameLableFrame) + CellBorder; //CGRectGetMaxX
        
        CGFloat vipY = iconViewXY;
        
        CGFloat vipW = 14;
        
        CGFloat vipH = nameSize.height;
        
        _vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    //发微博时间
    
    CGFloat timeLabelX = nameLabelX;
    
    CGFloat timeLabelY = CGRectGetMaxY(_nameLableFrame) + CellBorder;
    
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:StatusTimeFont];
    
    _timeLableFrame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //来源
    
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLableFrame) + CellBorder;
    
    CGFloat sourceLabelY = timeLabelY;
    
    CGSize sourceLabelSize = [status.source sizeWithAttributes:StatusTimeFont];
    
    _sourceLableFrame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //微博正文内容
    
    CGFloat textX = iconViewXY;
    
    CGFloat textY = MAX(CGRectGetMaxY(_iconViewFrame), CGRectGetMaxY(_timeLableFrame)) + CellBorder;//MAX宏方法的使用
    
    CGFloat textMaxW = topViewW - 2*CellBorder;
    
    // CGSize textSize = [status.text sizeWithFont:StatusTextFont constrainedToSize:CGSizeMake(textMaxW, MAXFLOAT)];
    
    CGSize textSize = [status.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:StatusTextFont context:nil].size;//boundingRectWithSize方法的使用
    
    _statusLableFrame = (CGRect){{textX,textY},textSize};
    
    
    
    //retweetImageFrame
    
    if (status.thumbnail_pic) {
        
        CGFloat statusImageX = iconViewXY;
        
        CGFloat statusImageY = CGRectGetMaxY(_statusLableFrame) + CellBorder;
        
        CGFloat statusImageWH = 70;
        
        _statusImageFrame = CGRectMake(statusImageX, statusImageY, statusImageWH, statusImageWH);
        
    }
    
    
    
    //被转发微博
    
    if (status.retweeted_status) {
        
        //retweetViewFrame
        
        CGFloat retweetViewX = iconViewXY;
        
        CGFloat retweetViewY = CGRectGetMaxY(_statusLableFrame) + CellBorder;
        
        CGFloat retweetViewW = textSize.width - 2*CellBorder;
        
        CGFloat retweetViewH = 0;
        
        
        
        //被转发微博的作者昵称retweetLableFrame
        
        CGFloat retweetLableXY = retweetViewX + CellBorder;
        
        CGSize retweetLableSize = [status.retweeted_status.user.idstr sizeWithAttributes:StatusNameFont];
        
        _retweetLableFrame = (CGRect){{retweetLableXY,retweetLableXY},retweetLableSize};
        
        
        
        //retweetStatusFrame
        
        CGFloat retweetStatusX = retweetLableXY;
        
        CGFloat retweetStatusY = CGRectGetMaxY(_retweetLableFrame) + CellBorder;
        
        CGFloat retweetStatusMaxW = retweetViewW - 2*CellBorder;
        
        CGSize retweetStatusSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetStatusMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:StatusTextFont context:nil].size;
        
        _retweetStatusFrame = (CGRect){{retweetStatusX,retweetStatusY},retweetStatusSize};
        
        
        
        //retweetImageFrame
        
        if (status.retweeted_status.thumbnail_pic) {
            
            CGFloat retweetImageX = retweetStatusX;
            
            CGFloat retweetImageY = CGRectGetMaxY(_retweetStatusFrame) + CellBorder;
            
            CGFloat retweetImageWH = 70;
            
            _retweetImageFrame = CGRectMake(retweetImageX, retweetImageY, retweetImageWH, retweetImageWH);
            
            
            
            retweetViewH = CGRectGetMaxY(_retweetImageFrame);
            
        }else{
            
            retweetViewH = CGRectGetMaxY(_retweetStatusFrame);
            
        }
        
        retweetViewH += CellBorder;
        
        _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        
        
        //有转发的时候
        
        topViewH = CGRectGetMaxY(_retweetViewFrame) + CellBorder;
        
    }else{
        
        if (status.thumbnail_pic) {//有图
            
            topViewH = CGRectGetMaxY(_retweetImageFrame) + CellBorder;
            
        }else{
            
            topViewH = CGRectGetMaxY(_statusLableFrame) + CellBorder;
            
        }
        
    }
    
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //计算cell 的高度
    
    _cellHeight = topViewH;
    
}

@end

