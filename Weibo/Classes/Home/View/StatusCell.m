//
//  StatusCell.m
//  Weibo
//
//  Created by 宿莽 on 15/12/11.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "StatusCell.h"

@interface StatusCell ()
/**
 *  底层View
 */
@property(nonatomic, weak)UIImageView *topView;
/**
 *  头像
 */
@property(nonatomic, weak)UIImageView *iconView;
/**
 *  会员图标
 */
@property(nonatomic, weak)UIImageView *vipView;
/**
 *  微博图片
 */
@property(nonatomic, weak)UIImageView *statusImage;
/**
 *  昵称
 */
@property(nonatomic, weak)UILabel *nameLable;
/**
 *  时间
 */
@property(nonatomic, weak)UILabel *timeLable;
/**
 *  微博文字内容
 */
@property(nonatomic, weak)UILabel *statusLable;
/**
 *  来源
 */
@property(nonatomic, weak)UILabel *sourceLable;
/**
 *  转发微博的容器View
 */
@property(nonatomic, weak)UIImageView *retweetView;
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
/**
 *  微博工具条
 */
@property(nonatomic, weak)UIImageView *statusToolBar;
@end

@implementation StatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
