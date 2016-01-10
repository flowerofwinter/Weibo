//
//  OriginalStatusView.m
//  Weibo
//
//  Created by 宿莽 on 15/12/22.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "OriginalStatusView.h"
#import "UIImageView+WebCache.h"
#import "Status.h"
#import "CellFrame.h"
#import "RetweetStatusView.h"
#import "StatusImage.h"
#import "ImageContainerView.h"
@interface OriginalStatusView()
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
@property(nonatomic, weak)ImageContainerView *statusImage;
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
@property(nonatomic, weak)RetweetStatusView *retweetView;
@end
@implementation OriginalStatusView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted"];
        [self setupSubView];
        //添加被转发微博内部的子控件
        [self setupRetweetSubviews];
    }
    return self;
}
/**
 *  添加微博的控件
 */
-(void)setupSubView{
    //2.头像
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    self.iconView = iconView;
    //3.会员图标
    UIImageView *vipView = [[UIImageView alloc]init];
    [self addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    //4.配图
    ImageContainerView *statusImage = [[ImageContainerView alloc]init];
    [self addSubview:statusImage];
    self.statusImage = statusImage;
    //5.昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.backgroundColor = [UIColor clearColor];//镂空；
    [self addSubview:nameLabel];
    self.nameLable = nameLabel;
    //6.时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor colorWithRed:1.00f green:0.77f blue:0.00f alpha:1.00f];
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    self.timeLable = timeLabel;
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:sourceLabel];
    self.sourceLable = sourceLabel;
    //8.正文内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0; //换行
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:contentLabel];
    self.statusLable = contentLabel;
}
/**
 *  添加被转发微博内部的子控件
 */
-(void)setupRetweetSubviews{
    //1.被转发微博的View
    RetweetStatusView *retweetView = [[RetweetStatusView alloc]init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

-(void)setFrameModel:(CellFrame *)frameModel{
    _frameModel = frameModel;
    //作者微博的数据
    [self setupTopViewData];
    //转发微博的数据
    [self setupRetweetData];
}
/**
 *  微博的数据
 */
-(void)setupTopViewData{
    Status *status = self.frameModel.status;
    WeiboUser *user = status.user;
    //2.头像
    // [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"app"]];
    //[self.iconView setImage:[UIImage imageNamed:@"avatar_default_big"]];
    // NSLog(@"%@",user.profile_image_url);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.frameModel.iconViewFrame;
    
    //3.昵称
    self.nameLable.text = user.name;
    self.nameLable.frame = self.frameModel.nameLableFrame;
    
    //4.是否是VIP
    if (user.mbrank) {
        self.vipView.hidden = NO;
        [self.vipView setImage:[UIImage imageNamed:@"common_icon_membership"]];
        self.vipView.frame = self.frameModel.vipViewFrame;
    }else{
        self.vipView.hidden = YES;
    }
    //发微博时间
    self.timeLable.text = status.created_at;
    CGFloat timeLabelX = self.frameModel.nameLableFrame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.frameModel.nameLableFrame) + CellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:StatusTimeFont];
    self.timeLable.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    //来源
    self.sourceLable.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLable.frame) + CellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:StatusTimeFont];
    self.sourceLable.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //7.正文
    self.statusLable.text = status.text;
    self.statusLable.frame = self.frameModel.statusLableFrame;
    
    //8.配图
    if (status.pic_urls.count) {
        self.statusImage.hidden = NO;
        self.statusImage.imageArr = status.pic_urls;
        self.statusImage.frame = self.frameModel.statusImageFrame;
    }else{
        self.statusImage.hidden = YES;
    }
}
/**
 *  设置转发微博的模型数据
 */
-(void)setupRetweetData{
    //  self.retweetView.frame = self.cellFrame.retweetViewFrame;
    Status *retweetStatus = self.frameModel.status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.frameModel.retweetViewFrame;
        self.retweetView.retweetData = self.frameModel;
    }else{
        self.retweetView.hidden = YES;
    }
}
@end
