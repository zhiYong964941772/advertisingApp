//
//  scan_Lai_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "scan_Lai_ViewController.h"
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
    WS(self);
    scan_Lai_View *scanV = [scan_Lai_View shareFactory];
    self.scanV = scanV;
    scanV.showResults = ^(UIAlertController *AV){
        SS(self);
        [strongself presentViewController:AV animated:YES completion:nil];
    };
    scanV.backgroundColor = [UIColor redColor];
    [self.view addSubview:scanV];
    [scanV mas_makeConstraints:^(MASConstraintMaker *make) {
        SS(self);
        make.center.equalTo(strongself.view);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //导航标题
    self.navigationItem.title = @"二维码/条形码";
    
    //导航右侧相册按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnOnClick)];
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
            WS(self);
            [self.scanV showAlertWithTitle:@"扫描结果" message:[[features firstObject] messageString] sureHandler:^{
                SS(self);

                [strongself.scanV stopScanning];
            } cancelHandler:^{
                SS(self);

                [strongself.scanV startScanning];

            }];
            
        }else{
            [self.scanV showAlertWithTitle:@"没有识别到二维码或条形码" message:nil sureHandler:nil cancelHandler:nil];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.scanV stopScanning];
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
