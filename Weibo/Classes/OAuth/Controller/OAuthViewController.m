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
#import "WeiboTool.h"
#import "MBProgressHUD+MJ.h"
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
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",AppKey,RedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    //3、设置根控制器为webview
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载……"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *str= request.URL.absoluteString;
    NSRange range = [str rangeOfString:@"code="];
    if (range.length) {
        int loc = range.location + range.length;
        NSString *code = [str substringFromIndex:loc];
        NSLog(@"%@",code);
        [self accountWithCode:code];
        return NO;//若无这一行，在网速卡的时候就会在第一次登陆的时候先显示回调的百度页面，因为afn的异步线程限于网速慢，还没有执行完毕，这里已经结束了，执行了下一句return yes
    }
    return YES;
}

-(void)accountWithCode:(NSString *)code{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = AppKey;
    params[@"client_secret"] = AppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = RedirectURI;
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        Account *account = [Account accountWithDict:responseObject];
        [AccountTool saveAccount:account];
        [WeiboTool chooseRootController];
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败%@",error);
        [MBProgressHUD hideHUD];
    }];
}
@end
