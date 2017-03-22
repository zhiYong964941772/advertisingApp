//
//  scan_Lai_View.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "scan_Lai_View.h"
#import <AVFoundation/AVFoundation.h>
@interface scan_Lai_View()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate>
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
#define cornnerW 26.0f
#define marginX (SCREEN_WIDTH - scanW) *0.5
#define marginY (SCREEN_HEIGHT - scanW - padding - labelH) *0.5
@implementation scan_Lai_View
+ (scan_Lai_View *)shareFactory{
    
       return [[scan_Lai_View alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT - 64)];;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //创建控件
        [self creatControl];
        
        //设置参数
        [self setupCamera];
        
        //添加定时器
        [self addTimer];
    }
    return self;
}
#pragma mark -- 创建视图控件
- (void)creatControl
{
       //遮盖视图
    }
#pragma mark -- 停止扫描
- (void)stopScanning{
    [_session stopRunning];
    _session = nil;
    [_preview removeFromSuperlayer];
    [self removeTimer];

}
#pragma mark -- 取消循环
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

@end
