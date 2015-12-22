//

//  StatusCell.m

//  Weibo

//

//  Created by 宿莽 on 15/12/11.

//  Copyright © 2015年 宿莽. All rights reserved.

//



#import "StatusCell.h"
#import "Status.h"
#import "WeiboUser.h"
#import "CellFrame.h"
#import "UIImageView+WebCache.h"
#import "StatusTooBbar.h"
#import "RetweetStatusView.h"
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
@property(nonatomic, weak)RetweetStatusView *retweetView;
/**
 *  微博工具条
 */
@property(nonatomic, weak)StatusTooBbar *statusToolBar;
@end

@implementation StatusCell

+(instancetype)cellWithTableView:(UITableView *)table{
    static NSString *ID = @"status";
    StatusCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加原创微博内部的子控件
        [self setupOriginalSubviews];
        //添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        //添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
-(void)setupOriginalSubviews{
    //0.设置cell选中时的的背景
//    UIImageView *bgView = [[UIImageView alloc]init];
//    bgView.image = [UIImage resizeImageWithName:@"common_card_background_highlighted"];
//    self.selectedBackgroundView = bgView;
    self.selectedBackgroundView = [[UIView alloc]init];
    //1.底部的Vie
    UIImageView *topView = [[UIImageView alloc]init];
    topView.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    //2.头像
    UIImageView *iconView = [[UIImageView alloc]init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    //3.会员图标
    UIImageView *vipView = [[UIImageView alloc]init];
    [self.topView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    //4.配图
    UIImageView *statusImage = [[UIImageView alloc]init];
    [self.topView addSubview:statusImage];
    self.statusImage = statusImage;
    //5.昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.backgroundColor = [UIColor clearColor];//镂空；
    [self.topView addSubview:nameLabel];
    self.nameLable = nameLabel;
    //6.时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor colorWithRed:1.00f green:0.77f blue:0.00f alpha:1.00f];
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLabel];
    self.timeLable = timeLabel;
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLabel];
    self.sourceLable = sourceLabel;
    //8.正文内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0; //换行
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.statusLable = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
-(void)setupRetweetSubviews{
    //1.被转发微博的View
    RetweetStatusView *retweetView = [[RetweetStatusView alloc]init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
}

/**
 *  添加微博工具条
 */
-(void)setupStatusToolBar{
    StatusTooBbar *statusToolBar = [[StatusTooBbar alloc]init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}

/**
 *  拦截Frame的设置
 */
-(void)setFrame:(CGRect)frame{
    frame.origin.y += CellWidth;
    frame.origin.x = CellWidth;
    frame.size.width -= 2*CellWidth; //与topView联动
    frame.size.height -= CellWidth; //与topView的cellHeight联动
    [super setFrame:frame];
}

/**
 *  传递模型数据
 *
 *  @param cellFrame 模型数据
 */
-(void)setCellFrame:(CellFrame *)cellFrame{
    _cellFrame = cellFrame;
    //原创微博
    [self setupOriginalData];
    //转发微博
    [self setupRetweetData];
    //微博工具条
    [self setupStatusBarData];
}

-(void)setupOriginalData{
    Status *status = self.cellFrame.status;
    WeiboUser *user = status.user;

    //1.topVIew
    self.topView.frame = self.cellFrame.topViewFrame;
    
    //2.头像
    // [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"app"]];
    //[self.iconView setImage:[UIImage imageNamed:@"avatar_default_big"]];
    // NSLog(@"%@",user.profile_image_url);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.cellFrame.iconViewFrame;
    
    //3.昵称
    self.nameLable.text = user.name;
    self.nameLable.frame = self.cellFrame.nameLableFrame;
    
    //4.是否是VIP
    if (user.mbrank) {
        self.vipView.hidden = NO;
        [self.vipView setImage:[UIImage imageNamed:@"common_icon_membership"]];
        self.vipView.frame = self.cellFrame.vipViewFrame;
    }else{
        self.vipView.hidden = YES;
    }
    
    //发微博时间
    self.timeLable.text = status.created_at;
    CGFloat timeLabelX = self.cellFrame.nameLableFrame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.cellFrame.nameLableFrame) + CellBorder;
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
    self.statusLable.frame = self.cellFrame.statusLableFrame;
    
    //8.配图
    if (status.thumbnail_pic) {
        self.statusImage.hidden = NO;
        [self.statusImage sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"app"]];
        self.statusImage.frame = self.cellFrame.statusImageFrame;
    }else{
        self.statusImage.hidden = YES;
    }
}

-(void)setupRetweetData{
  //  self.retweetView.frame = self.cellFrame.retweetViewFrame;
    Status *retweetStatus = self.cellFrame.status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.cellFrame.retweetViewFrame;
        self.retweetView.retweetData = self.cellFrame;
    }else{
        self.retweetView.hidden = YES;
    }
}

-(void)setupStatusBarData{
    self.statusToolBar.frame = self.cellFrame.statusToolBarFrame;
    self.statusToolBar.status = self.cellFrame.status;
}

@end

