//
//  scan_Lai_View.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "scan_Lai_View.h"
#import <AVFoundation/AVFoundation.h>
@interface scan_Lai_View()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, weak) UIImageView *line;
@property (nonatomic, assign) NSInteger distance;

@end
#define scanW SCREEN_WIDTH*0.65
#define padding 10.0f
#define labelH 20.0f
#define tabBarH 64.0f
#define cornerW 26.0f
#define marginX (SCREEN_WIDTH - scanW) *0.5
#define marginY (SCREEN_HEIGHT - scanW - padding - labelH) *0.5
@implementation scan_Lai_View
+ (scan_Lai_View *)shareFactory{
    
       return [[scan_Lai_View alloc]init];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        //创建控件
        [self creatControl];
        
//        //设置参数
        [self setupCamera];
//        
//        //添加定时器
        [self addTimer];
    }
    return self;
}
#pragma mark -- 创建视图控件
- (void)creatControl
{
    //遮盖视图
    for (int i = 0; i < 4; i++) {
        UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, (marginY + scanW) * i, SCREEN_WIDTH, marginY + (padding + labelH) * i)];
        if (i == 2 || i == 3) {
            cover.frame = CGRectMake((marginX + scanW) * (i - 2), marginY, marginX, scanW);
        }
        cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [self addSubview:cover];
    }
    
    //扫描视图
    UIView *scanView = [[UIView alloc] initWithFrame:CGRectMake(marginX, marginY, scanW, scanW)];
    [self addSubview:scanView];
    
    //扫描线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanW, 2)];
    [self drawLineForImageView:line];
    [scanView addSubview:line];
    self.line = line;
    
    //边框
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanW, scanW)];
    borderView.layer.borderColor = [[UIColor whiteColor] CGColor];
    borderView.layer.borderWidth = 1.0f;
    [scanView addSubview:borderView];
    
    //扫描视图四个角
    for (int i = 0; i < 4; i++) {
        CGFloat imgViewX = (scanW - cornerW) * (i % 2);
        CGFloat imgViewY = (scanW - cornerW) * (i / 2);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, cornerW, cornerW)];
        if (i == 0 || i == 1) {
            imgView.transform = CGAffineTransformRotate(imgView.transform, M_PI_2 * i);
        }else {
            imgView.transform = CGAffineTransformRotate(imgView.transform, - M_PI_2 * (i - 1));
        }
        [self drawImageForImageView:imgView];
        [scanView addSubview:imgView];
    }
    
    //提示标签
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scanView.frame) + padding, SCREEN_WIDTH, labelH)];
    label.text = @"将二维码/条形码放入框内，即可自动扫描";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    //选项栏
    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - tabBarH, SCREEN_WIDTH, tabBarH)];
    tabBarView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    [self addSubview:tabBarView];
    
    //开启照明按钮
    UIButton *lightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, tabBarH)];
    lightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [lightBtn setTitle:@"开启照明" forState:UIControlStateNormal];
    [lightBtn setTitle:@"关闭照明" forState:UIControlStateSelected];
    [lightBtn addTarget:self action:@selector(lightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:lightBtn];
    }
- (void)setupCamera
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //初始化相机设备
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        //初始化输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
        
        //初始化输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        //设置代理，主线程刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        //初始化链接对象
        _session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        if ([_session canAddInput:input]) [_session addInput:input];
        if ([_session canAddOutput:output]) [_session addOutput:output];
        
        //条码类型（二维码/条形码）
        output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
        
        //更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            _preview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.layer insertSublayer:_preview atIndex:0];
            [_session startRunning];
        });
    });
}
- (void)addTimer
{
    _distance = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    if (_distance++ > SCREEN_WIDTH * 0.65) _distance = 0;
    _line.frame = CGRectMake(0, _distance, SCREEN_WIDTH * 0.65, 2);
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描完成
    if ([metadataObjects count] > 0) {
        [self stopScanning];
        self.pushWebVC([[metadataObjects firstObject] stringValue]);
        //显示结果
    }
}


#pragma mark -- 停止扫描
- (void)stopScanning{
    [_session stopRunning];
//    _session = nil;
//    [_preview removeFromSuperlayer];
    [self removeTimer];

}
#pragma mark -- 继续扫描
- (void)startScanning{
    if (self.timer) {
    }else{
        [self addTimer];
    }
    if (_session) {
        [_session startRunning];

    }
}
#pragma mark -- 取消循环
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}
//绘制扫描线
- (void)drawLineForImageView:(UIImageView *)line{
    CGSize size = line.bounds.size;
    UIGraphicsBeginImageContext(size);//获取绘制大小
    CGContextRef context = UIGraphicsGetCurrentContext();//获取上下文
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建一个颜色空间
    const CGFloat *startColor = CGColorGetComponents([UIColor greenColor].CGColor);    //设置开始颜色

    const CGFloat *endColor = CGColorGetComponents([UIColor whiteColor].CGColor);    //设置结束颜色

    CGFloat components[8] = {startColor[0],startColor[1],startColor[2],startColor[3],endColor[0],endColor[1],endColor[2],endColor[3]};    //颜色分量的强度值数组

    CGFloat locations[] = {0.0,1.0};    //渐变系数数组

    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(size.width*0.5, size.height*0.5), size.width*0.25,CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.5, kCGGradientDrawsBeforeStartLocation);    //创建渐变对象，关联到所绘制的视图中

    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);    //释放

    
    line.image = UIGraphicsGetImageFromCurrentImageContext();    //获取绘制的图形

    UIGraphicsEndImageContext();    //结束上下文对象获取

}
//绘制角图片
- (void)drawImageForImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, 6.0f);
    //设置颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
    //路径
    CGContextBeginPath(context);
    //设置起点坐标
    CGContextMoveToPoint(context, 0, imageView.bounds.size.height);
    //设置下一个点坐标
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, imageView.bounds.size.width, 0);
    //渲染，连接起点和下一个坐标点
    CGContextStrokePath(context);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
//照明按钮点击事件
- (void)lightBtnOnClick:(UIButton *)btn
{
    //判断是否有闪光灯
    if (![_device hasTorch]) {
        [self showAlertWithTitle:@"当前设备没有闪光灯，无法开启照明功能" message:nil sureHandler:nil cancelHandler:nil];
        return;
    }
    
    btn.selected = !btn.selected;
    
    [_device lockForConfiguration:nil];
    if (btn.selected) {
        [_device setTorchMode:AVCaptureTorchModeOn];
    }else {
        [_device setTorchMode:AVCaptureTorchModeOff];
    }
    [_device unlockForConfiguration];
}
//提示弹窗
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message sureHandler:(void (^)())sureHandler cancelHandler:(void (^)())cancelHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:sureHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelHandler];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    self.showResults(alertController);
}

@end
