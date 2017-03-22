//
//  scan_Lai_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "scan_Lai_ViewController.h"

@interface scan_Lai_ViewController ()<UIImagePickerControllerDelegate>

@end

@implementation scan_Lai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化信息
    [self initInfo];
    
//    //创建控件
//    [self creatControl];
//    
//    //设置参数
//    [self setupCamera];
//    
//    //添加定时器
//    [self addTimer];
}
- (void)initInfo
{
    //背景色
    self.view.backgroundColor = [UIColor blackColor];
    
    //导航标题
    self.navigationItem.title = @"二维码/条形码";
    
    //导航右侧相册按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnOnClick)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self stopScanning];
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
