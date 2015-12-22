//
//  RetweetStatusView.h
//  Weibo
//
//  Created by 宿莽 on 15/12/22.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFrame.h"
#import "WeiboUser.h"
#import "Status.h"
@interface RetweetStatusView : UIImageView
/**
 *  被转发的微博的模型信息
 */
@property(nonatomic,strong)CellFrame *retweetData;
@end
