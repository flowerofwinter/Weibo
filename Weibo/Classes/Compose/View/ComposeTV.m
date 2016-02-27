//
//  ComposeTV.m
//  Weibo
//
//  Created by 宿莽 on 16/2/27.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import "ComposeTV.h"
@interface ComposeTV()
@property(nonatomic, weak)UILabel *placeholderLabel;
@end
@implementation ComposeTV

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.textColor = [UIColor grayColor];
        placeholderLabel.backgroundColor = [UIColor redColor];
        placeholderLabel.hidden = YES;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        //计算frame
        NSDictionary * attributes = @{NSFontAttributeName: self.placeholderLabel.font};
        CGFloat placeholderW = [placeholder sizeWithAttributes:attributes].width;
        CGFloat placeholderH = [placeholder sizeWithAttributes:attributes].height;
        
        self.placeholderLabel.frame = CGRectMake(0, 0, placeholderW, placeholderH);
    }else{
        self.placeholderLabel.hidden = YES;
    }
}
@end
