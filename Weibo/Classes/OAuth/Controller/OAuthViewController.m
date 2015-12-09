//
//  OAuthViewController.m
//  Weibo
//
//  Created by 宿莽 on 15/12/7.
//  Copyright © 2015年 宿莽. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1、添加webview
    UIWebView *webview = [[UIWebView alloc]init];
    webview.frame = self.view.bounds;
    webview.delegate = self;
    [self.view addSubview:webview];
    //2、打开webview
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=944083771&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    //3、设置根控制器为webview
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *str= request.URL.absoluteString;
    NSRange range = [str rangeOfString:@"code="];
    if (range.length) {
        int loc = range.location + range.length;
        NSString *code = [str substringFromIndex:loc];
        NSLog(@"%@",code);
        [self accountWithCode:code];
    }
    return YES;
}

-(void)accountWithCode:(NSString *)code{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"944083771";
    params[@"client_secret"] = @"588d0a822123a9b13c5f7482eea335ed";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        Account *account = [Account accountWithDict:responseObject];
        [AccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败%@",error);
    }];
}
@end
