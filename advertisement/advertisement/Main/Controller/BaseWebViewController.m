//
//  BaseWebViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
@property (nonatomic,weak)UIWebView *webView;
@property (nonatomic,copy)NSString *urlStr;
@end

@implementation BaseWebViewController
#define footerViewH 44
#define viewH SCREEN_HEIGHT - footerViewH
+ (BaseWebViewController *)pushWebVC:(NSString *)urlStr{
    BaseWebViewController *bWeb = [[BaseWebViewController alloc]init];
    bWeb.urlStr = urlStr;
    return bWeb;
}
- (BaseWebViewController *)tipsUrl:(void(^)(NSString *url))urlStr{
    if (self.urlStr.length>0) {
        urlStr(self.urlStr);
    }else{
        urlStr(@"地址为空");
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatFooterView];
}
- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    [self creatWebView];
}
#pragma mark -- webView的创建
- (void)creatWebView{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,viewH-64)];
    web.scalesPageToFit = YES;
    web.delegate = self;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];

    self.webView = web;
    
    [self.view addSubview:web];
}
#pragma mark -- webDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"ni");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}
#pragma mark -- 底部视图的创建
- (void)creatFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0,viewH,SCREEN_WIDTH ,footerViewH)];
    footerView.backgroundColor = BASECOLORL(200, 200, 200);
    CGFloat buttonW = SCREEN_WIDTH *0.3;
    for (int i = 0; i<3; i++) {
        UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        footerButton.frame = CGRectMake(20+(i*buttonW),0,buttonW,footerViewH);
        switch (i) {
            case 0:
            {
                [footerButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
                [footerButton addTarget:self action:@selector(retreatAction) forControlEvents:UIControlEventTouchUpInside];
                
            }
                break;
            case 1:
            {
                [footerButton setImage:[UIImage imageNamed:@"前进"] forState:UIControlStateNormal];
                [footerButton addTarget:self action:@selector(advanceAction) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 2:
            {
                [footerButton setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
                [footerButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            default:
                break;
        }
        [footerView addSubview:footerButton];
    }

    [self.view addSubview:footerView];
}
#pragma mark -- 后退
- (void)retreatAction{
    
}
#pragma mark -- 前进
- (void)advanceAction{
    
}

#pragma mark -- 刷新
- (void)refreshAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
