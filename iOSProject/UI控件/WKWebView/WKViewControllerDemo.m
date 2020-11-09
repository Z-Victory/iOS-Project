//
//  WKViewControllerDemo.m
//  iOSProject
//
//  Created by mana on 2020/6/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "WKViewControllerDemo.h"
#import <WebKit/WebKit.h>

@interface WKViewControllerDemo ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
//@property WebViewJavascriptBridge * bridge;
@end

@implementation WKViewControllerDemo
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"URL"];
    if (self.progressView) {
        [self.progressView removeFromSuperview];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.URLString = @"www.baidu.com";
    [self setUI];
}
- (void)setUI{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        configuration.allowsInlineMediaPlayback = true;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:configuration];
        
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.backgroundColor = [UIColor systemGroupedBackgroundColor];
//    __weak typeof(self) weakSelf = self;
    //配置下拉刷新
//    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.webView reload];
//        [weakSelf.webView.scrollView.mj_header endRefreshing];
//    }];
    [self.view addSubview:self.webView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    //配置WebViewJavascriptBridge
    [self settingJSOCInteraction];
    
    
    //nil 直接跳过
    if(!self.URLString) return;
        
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:(self.URLString)] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    [self.webView loadRequest:request];

    
    //进度条
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88-2, [UIScreen mainScreen].bounds.size.width, 2)];
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    //已加载的进度条颜色
    self.progressView.progressTintColor = UIColor.blackColor;
    [self.navigationController.view addSubview:self.progressView];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    //设置userAgent
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable oldAgent, NSError * _Nullable error) {
//        oldAgent = [[UserAgent ShardInstnce] getUserAgent];
        
        NSString *newAgent = [@"" stringByAppendingFormat:@" DWD_HSQ/%@",@"&MANA"];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":newAgent}];
        // 一定要设置customUserAgent，否则执行navigator.userAgent拿不到oldAgent
        self.webView.customUserAgent = newAgent;
    }];
    
    
    // 监听将要隐藏 有时键盘隐藏后位置没有归位
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden) name:UIKeyboardWillHideNotification object:nil];
}
// 键盘将要隐藏
- (void)keyBoardHidden {
    self.webView.scrollView.contentOffset = CGPointMake(0, 0);
}
//点击返回，逐级返回
- (void)backClick{
    if([_webView canGoBack])
    {
        [_webView goBack];
    }
    else
    {
        //最低层
//        [self back];
    }
}
//配置WebViewJavascriptBridge
- (void)settingJSOCInteraction{
//    [WebViewJavascriptBridge enableLogging];
//
//    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
//    [_bridge setWebViewDelegate:self];
    //注册监听
//    [_bridge registerHandler:@"app_personalHome" handler:^(id data, WVJBResponseCallback responseCallback) {
//        if (!LMJIsEmpty(data)) {
//            NSInteger userid = [data[@"userId"] integerValue];
//            [DKJumpManager pushPersonalHomeVC:userid];
//        }
//    }];
    
}
- (void)testCaller{
    
}
@end
