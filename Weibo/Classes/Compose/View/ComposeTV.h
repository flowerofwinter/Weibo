//
//  ComposeTV.h
//  Weibo
//
//  Created by 宿莽 on 16/2/27.
//  Copyright © 2016年 宿莽. All rights reserved.
//

/*
 UITextField:不能换行
 UITextView:没有提示文字
 */
#import <UIKit/UIKit.h>

@interface ComposeTV : UITextView
//@property(nonatomic, weak)UILabel *placeholderLable;
@property(nonatomic,copy)NSString *placeholder;
@end
