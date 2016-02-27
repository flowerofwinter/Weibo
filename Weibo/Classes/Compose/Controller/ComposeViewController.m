//
//  ComposeViewController.m
//  Weibo
//
//  Created by 宿莽 on 16/2/27.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeTV.h"
@interface ComposeViewController ()
@property(nonatomic, weak)ComposeTV *composeView;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    //设置textView
    [self setupTextView];
}

-(void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

-(void)setupTextView{
    //添加textView
    ComposeTV *composeView = [[ComposeTV alloc]init];
    composeView.font = [UIFont systemFontOfSize:15];
    composeView.frame = self.view.bounds;//这样设置，输入光标应该在左上角，实则不是，why，textview继承自scrollview，contentInset有额外的长度为64的区域
    [self.view addSubview:composeView];
    self.composeView = composeView;
    //添加监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:composeView];
}

-(void)textDidChange{
//    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = self.composeView.text.length;
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send{
    NSLog(@"☀️");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
