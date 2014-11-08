//
//  OauthViewController.m
//  xinlangweibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "OauthViewController.h"
//#import "AFNetworking.h"
#import "Account.h"
#import "TabBarViewController.h"
#import "Newfeature.h"
#import "IWAccountTool.h"
#import "IWWeiboTool.h"
#import "HttpTool.h"
@interface OauthViewController ()<UIWebViewDelegate>

@end

@implementation OauthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    webView.delegate = self;
    [self.view addSubview:webView];
    // 加载请求页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3129139517&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length) {
//        NSLog(@"range.location==%d",range.location);
//        NSLog(@"range.length==%d",range.length);
         int loc = range.location + range.length;
        NSString *code = [urlString substringFromIndex:loc];
        // 发送post请求给新浪，用code换取access_token
        [self accessToken:code];
        return NO;
           }
//    NSLog(@"request==%@  %@",urlString,NSStringFromRange(range));
//    NSLog(@"navigetiontype==%d",navigationType);
    return YES;
}

- (void)accessToken:(NSString *)code
{
    
    // 2封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"3129139517";
    parameters[@"client_secret"] = @"64263e3fbe3febb6776c734ee393e384";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.baidu.com";
 // 1创建请求管理对象
    [HttpTool postWithUrl:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(id responseObject) {
        // 模型
        // 4.先将字典转为模型
        Account *account = [Account accountWithDict:responseObject];
        
        // 5.存储模型数据
        [IWAccountTool saveAccount:account];
        
        // 6.新特性\去首页
        [IWWeiboTool chooseRootController];

    } failure:^(NSError *error) {
        Log(@"失败");
    }];
    



}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
