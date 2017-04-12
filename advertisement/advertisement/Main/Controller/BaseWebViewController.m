//
//  BaseWebViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "BaseWebViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface BaseWebViewController ()<UIWebViewDelegate>
@property (nonatomic,weak)UIWebView *webView;
@property (nonatomic,copy)NSString *urlStr;
@property (nonatomic ,strong)JSContext *context;
@property (nonatomic, assign)BOOL isScan;

@end

@implementation BaseWebViewController
#define footerViewH 44
#define viewH SCREEN_HEIGHT - footerViewH
+ (BaseWebViewController *)pushWebVC:(NSString *)urlStr WithIsScan:(BOOL)isScan{
    BaseWebViewController *bWeb = [[BaseWebViewController alloc]init];
    bWeb.isScan = isScan;
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
- (JSContext *)context{
    if (!_context) {
        _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
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
    web.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];

    self.webView = web;
    
    [self.view addSubview:web];
}
#pragma mark -- webDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    if ([self.urlStr isEqualToString:webView.request.URL.absoluteString]&&(self.isScan==YES)) {
        //保存浏览信息到数据库
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
           BOOL isQuery = [context queryTableExists:title];
            if (isQuery) {
                NSLog(@"%@已经存在,只更新表",self.title);
                context.deleteObject(title).addObject(title,self.urlStr,[self getImageData]);
            }else{
                context.addObject(title,self.urlStr,[self getImageData]);
            }
        }];
    }
    [self endRefreshAction];

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
    
    NSString *jsFunctStr1=@"history.back();";
    [self.context evaluateScript:jsFunctStr1];

}
#pragma mark -- 前进
- (void)advanceAction{
    NSString *jsFunctStr1=@"history.forward();";
    [self.context evaluateScript:jsFunctStr1];
}

#pragma mark -- 刷新
- (void)refreshAction{
    NSString *jsFunctStr1=@"location.reload();";
    [self.context evaluateScript:jsFunctStr1];
}
#pragma mark -- 结束刷新
- (void)endRefreshAction{
    [self.webView.scrollView.mj_header endRefreshing];
}
#pragma mark -- 获取截图
- (NSData *)getImageData{
    UIGraphicsBeginImageContext(self.webView.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(image);
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
