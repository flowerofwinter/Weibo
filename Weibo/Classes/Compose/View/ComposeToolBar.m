//
//  ComposeToolBar.m
//  Weibo
//
//  Created by 宿莽 on 16/2/28.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import "ComposeToolBar.h"

@implementation ComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
    }
    return self;
}
@end
