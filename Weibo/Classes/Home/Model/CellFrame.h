//
//  CellFrame.h
//  Weibo
//
//  Created by 宿莽 on 15/12/16.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CellBorder 5
#define StatusNameFont @{NSFontAttributeName:[UIFont systemFontOfSize:14]}
#define StatusTimeFont @{NSFontAttributeName:[UIFont systemFontOfSize:12]}
#define StatusTextFont @{NSFontAttributeName:[UIFont systemFontOfSize:13]}
//cell的缩进
#define CellWidth 5
@class Status;
@interface CellFrame : NSObject
/**
 *  底层View
 */
@property(nonatomic, assign,readonly)CGRect topViewFrame;
/**
 *  头像
 */
@property(nonatomic, assign,readonly)CGRect iconViewFrame;
/**
 *  会员图标
 */
@property(nonatomic, assign,readonly)CGRect vipViewFrame;
/**
 *  微博图片
 */
@property(nonatomic, assign,readonly)CGRect statusImageFrame;
/**
 *  昵称
 */
@property(nonatomic, assign,readonly)CGRect  nameLableFrame;
/**
 *  时间
 */
@property(nonatomic, assign,readonly)CGRect  timeLableFrame;
/**
 *  微博文字内容
 */
@property(nonatomic, assign,readonly)CGRect  statusLableFrame;
/**
 *  来源
 */
@property(nonatomic, assign,readonly)CGRect  sourceLableFrame;
/**
 *  转发微博的容器View
 */
@property(nonatomic, assign,readonly)CGRect retweetViewFrame;
/**
 *  被转发作者的昵称
 */
@property(nonatomic, assign,readonly)CGRect  retweetLableFrame;
/**
 *  被转发的内容
 */
@property(nonatomic, assign,readonly)CGRect  retweetStatusFrame;
/**
 *  被转发的微博图片
 */
@property(nonatomic, assign,readonly)CGRect retweetImageFrame;
/**
 *  微博工具条
 */
@property(nonatomic, assign,readonly)CGRect statusToolBarFrame;
/**
 *  cell的高度
 */
@property(nonatomic, assign,readonly)CGFloat cellHeight;
@property(nonatomic,strong)Status *status;

@end
