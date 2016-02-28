//
//  ComposeToolBar.h
//  Weibo
//
//  Created by 宿莽 on 16/2/28.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ComposeToolBarButtonTypeCamera,
    ComposeToolBarButtonTypePicture,
    ComposeToolBarButtonTypeMention,
    ComposeToolBarButtonTypeTrend,
    ComposeToolBarButtonTypeEmotion
}ComposeToolBarButtonType;
@class ComposeToolBar;
@protocol ComposeToolBarDelegate <NSObject>

@optional
-(void)composeToolbar:(ComposeToolBar *)toolbar didClickButton:(ComposeToolBarButtonType)ComposeToolBarButtonType;
@end
@interface ComposeToolBar : UIView
@property(nonatomic, weak)id<ComposeToolBarDelegate> delegate;
@end
