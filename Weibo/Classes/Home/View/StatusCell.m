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
#import "OriginalStatusView.h"
@interface StatusCell ()

/**
 *  底层View
 */
@property(nonatomic, weak)OriginalStatusView *topView;
/**
 *  微博工具条
 */
@property(nonatomic, weak)StatusTooBbar *statusToolBar;
@end

@implementation StatusCell
#pragma mark - 初始化
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
    OriginalStatusView *topView = [[OriginalStatusView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
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
 */
-(void)setCellFrame:(CellFrame *)cellFrame{
    _cellFrame = cellFrame;
    //原创微博
    [self setupOriginalData];
    //微博工具条
    [self setupStatusBarData];
}
/**
 *  设置微博作者的的数据
 */
-(void)setupOriginalData{
    self.topView.frame = self.cellFrame.topViewFrame;
    self.topView.frameModel = self.cellFrame;
}
/**
 *  设置工具条的模型数据
 */
-(void)setupStatusBarData{
    self.statusToolBar.frame = self.cellFrame.statusToolBarFrame;
    self.statusToolBar.status = self.cellFrame.status;
}

@end

