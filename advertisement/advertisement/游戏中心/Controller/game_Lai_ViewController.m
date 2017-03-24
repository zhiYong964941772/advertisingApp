//
//  game_Lai_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "game_Lai_ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface game_Lai_ViewController ()<UIWebViewDelegate>
@property (nonatomic ,weak)UIWebView *web;
@property (nonatomic ,strong)JSContext *context;

@end
@implementation game_Lai_ViewController
- (JSContext *)context{
    if (!_context) {
        _context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWebView];
    
}
- (void)creatRightBtn{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackAction)];
     UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(reloadAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.leftBarButtonItem = leftBtn;
}
- (void)creatWebView{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,self.view.bounds.size.height-44)];
    self.web = web;
    web.scalesPageToFit = YES;
    web.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://hangliaokj.cn:8081/game/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
   

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length>0&&![title isEqualToString:@"行聊游戏"]) {
        self.title = title;
        [self creatRightBtn];

    }else{
        NSString *jsFunctStr=@"var script = document.createElement('script');"
        "script.type = 'text/javascript';"
        "script.text = \"function myFunction() { "   //定义myFunction方法
        "var div = document.getElementsByClassName('tabBtn').item(0);"
        "div.remove();"
        "}\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
        [self.context evaluateScript:jsFunctStr];
        
        //二个参数
        NSString *jsFunctStr1=@"myFunction();";
        [self.context evaluateScript:jsFunctStr1];
        
           }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 按钮事件
- (void)goBackAction{
    [self.web goBack];
}
- (void)reloadAction{
    [self.web reload];
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
