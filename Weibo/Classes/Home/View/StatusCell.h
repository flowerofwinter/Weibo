//
//  StatusCell.h
//  Weibo
//
//  Created by 宿莽 on 15/12/11.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellFrame;
@interface StatusCell : UITableViewCell
@property(nonatomic,strong)CellFrame *cellFrame;
+(instancetype)cellWithTableView:(UITableView *)table;
@end
