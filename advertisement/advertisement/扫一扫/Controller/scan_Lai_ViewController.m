//
//  scan_Lai_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "scan_Lai_ViewController.h"
#import "BaseWebViewController.h"
#import "scan_Lai_View.h"
@interface scan_Lai_ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak)scan_Lai_View *scanV;
@end

@implementation scan_Lai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化信息
    [self initInfo];
    

}
- (void)initInfo
{
    //背景色
    self.view.backgroundColor = [UIColor blackColor];
    @weakify(self);
    scan_Lai_View *scanV = [scan_Lai_View shareFactory];
    self.scanV = scanV;
    scanV.showResults = ^(UIAlertController *AV){
        @strongify(self);
        [self presentViewController:AV animated:YES completion:nil];
    };
    scanV.pushWebVC = ^(NSString *url){
        @strongify(self);
        [self pushWebVC:url];
    };
    [self.view addSubview:scanV];
    [scanV mas_makeConstraints:^(MASConstraintMaker *make) {
        SS(self);
        make.center.equalTo(strongself.view);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //导航标题
    self.title = @"二维码/条形码";
    
    //导航右侧相册按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnOnClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(selectTarbarChildVC)];
}
#pragma mark -- 跳转到历史
- (void)selectTarbarChildVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//进入相册
- (void)photoBtnOnClick
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }else {
        [self.scanV showAlertWithTitle:@"当前设备不支持访问相册" message:nil sureHandler:nil cancelHandler:nil];
    }
}
#pragma mark - UIImagePickerControllrDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        //获取相册图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        //识别图片
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        
        //识别结果
        if (features.count > 0) {
            [self.scanV stopScanning];
            [self pushWebVC:[[features firstObject] messageString]];
        }else{
            [self.scanV showAlertWithTitle:@"没有识别到二维码或条形码" message:nil sureHandler:nil cancelHandler:nil];
        }
    }];
}
#pragma mark -- 加载webView
- (void)pushWebVC:(NSString *)url{
   BaseWebViewController *bWeb = [[BaseWebViewController pushWebVC:url]tipsUrl:^(NSString *str) {
       NSLog(@"%@",str);
   }];
    [self.navigationController pushViewController:bWeb animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.scanV stopScanning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.scanV) {
        [self.scanV startScanning];
    }
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
