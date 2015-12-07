//
//  OAuthViewController.m
//  Weibo
//
//  Created by 宿莽 on 15/12/7.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "OAuthViewController.h"

@interface OAuthViewController ()

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1、添加webview
    UIWebView *webview = [[UIWebView alloc]init];
    webview.frame = self.view.bounds;
    [self.view addSubview:webview];
    //2、打开webview
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=944083771&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    //3、设置根控制器为webview
}


@end
