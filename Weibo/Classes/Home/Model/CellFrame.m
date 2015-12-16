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
    //计算topview的frame
    CGFloat topWiewH = CGRectGetMaxY(_statusLableFrame) + CellBorder;
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topWiewH);
    //计算cell 的高度
    _cellHeight = topWiewH;
}
@end
