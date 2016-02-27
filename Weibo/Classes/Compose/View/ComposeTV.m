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
        //添加提示文字
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.textColor = [UIColor grayColor];
       // placeholderLabel.backgroundColor = [UIColor redColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.font = self.font;
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        //监听通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)textDidChange{
        self.placeholderLabel.hidden = self.text.length;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        //计算frame
        NSDictionary * attributes = @{NSFontAttributeName: self.placeholderLabel.font};
//        CGFloat placeholderH = [placeholder sizeWithAttributes:attributes].height;
        CGRect placeholderRect = [placeholder boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        self.placeholderLabel.frame = placeholderRect;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

-(void)setPlaceholdercolor:(UIColor *)placeholdercolor{
    _placeholdercolor = placeholdercolor;
    self.placeholderLabel.textColor = placeholdercolor;
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;//重算label的frame
}

@end
