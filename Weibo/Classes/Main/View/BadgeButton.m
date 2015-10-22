//
//  BadgeButton.m
//  Weibo
//
//  Created by 宿莽 on 15/10/16.
//  Copyright (c) 2015年 宿莽. All rights reserved.
//

#import "BadgeButton.h"

@implementation BadgeButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
#warning copy
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        //设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length>1) {
            CGSize badgeSize = [badgeValue boundingRectWithSize:CGSizeMake(200, 0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }else{
        self.hidden = YES;
    }

}
@end
