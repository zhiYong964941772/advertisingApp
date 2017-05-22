//
//  qrCode_Lai_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/5/17.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "qrCode_Lai_ViewController.h"
#import <Photos/Photos.h>
@interface qrCode_Lai_ViewController ()<UITextViewDelegate>
@property (nonatomic, strong)NSString *tvT;
@property (nonatomic, strong)UIButton *pab;//保存到相册
@property (nonatomic, strong)UIButton *cb;//生成
@property (nonatomic, strong)RACSignal *tvSignal;
@property (nonatomic, strong)RACCommand *cbCommand;
@property (nonatomic, strong)RACCommand *pabCommand;

@property (nonatomic, strong)UITextView *tv;//二维码信息输入框
@property (nonatomic, strong)UIImageView *iv;//二维码展示图


@end

@implementation qrCode_Lai_ViewController
#define CREATQR @"生成二维码"
#define SAVEPHOTO @"保存到相册"
#define QRBTN SCREEN_WIDTH*0.2
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码世界";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self creatUI];
    [self responseControl];
}
#pragma mark -- 界面视图布局
- (void)creatUI{
    _tv = [[UITextView alloc]init];
    _tv.clipsToBounds = YES;
    _tv.layer.borderWidth = 2;
    _tv.layer.borderColor = [UIColor blackColor].CGColor;
    _tv.textAlignment = NSTextAlignmentLeft;
    _tv.delegate = self;
    _tvSignal = _tv.rac_textSignal ;
    _pab = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pab setTitle:SAVEPHOTO forState:UIControlStateNormal];
    [_pab setBackgroundColor:BASECOLORL(200, 200, 200)];
    [_pab setTitleColor:BASECOLORL(0, 0, 0) forState:UIControlStateNormal];
    [_pab setFont:[UIFont systemFontOfSize:12]];
    _pab.enabled = NO;
    [[_pab rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [_pabCommand execute:SAVEPHOTO];
    }];
    
    _cb = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cb setTitle:CREATQR forState:UIControlStateNormal];
    [_cb setBackgroundColor:BASECOLORL(200, 200, 200)];
    [_cb setFont:[UIFont systemFontOfSize:12]];
    [_cb setTitleColor:BASECOLORL(0, 0, 0) forState:UIControlStateNormal];
    [[_cb rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [_cbCommand execute:CREATQR];
    }];
    
    _iv = [UIImageView makeImageViewWithBlock:^(UIImageView *imageView) {
        imageView.addContentMode(UIViewContentModeScaleAspectFill);
    }];

    [self.view addSubview:_tv];
    [self.view addSubview:_pab];
    [self.view addSubview:_cb];
    [self.view addSubview:_iv];
#pragma mark -- 添加约束
    [_tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(QRBTN);
    }];
    [_cb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tv.mas_bottom).with.offset(10);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(QRBTN,30));
    }];
    [_pab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tv.mas_bottom).with.offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(QRBTN,30));

    }];
    [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pab.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(QRBTN*2, QRBTN*2));

    }];


}
#pragma mark -- 响应事件
- (void)responseControl{
    #pragma mark -- 转换内容
    [_tvSignal subscribeNext:^(id x) {
        self.tvT = x;
        
    }];
    #pragma mark -- 生成二维码
     _cbCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
         _cb.enabled = NO;//2
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if (self.tvT.length>0) {
            [subscriber sendNext:CREATQR];//4
            }
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [_cbCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isEqualToString:CREATQR]) {
            [self creatQR];//5
        }
    }];
    [[_cbCommand.executing skip:1] subscribeNext:^(id x) {//1.3.6
        if ([x isEqualToNumber:@(YES)]) {
            
        }else{
            _pab.enabled = YES;
            [self deleteKeyBoard];
        }
    }];
   #pragma mark -- 保存相册
    _pabCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@",SAVEPHOTO);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:SAVEPHOTO];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [_pabCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isEqualToString:SAVEPHOTO]) {
            [self creatSharedPhotoLibrary];
        }
    }];

    [[_pabCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            
        }else{
            _pab.enabled = NO;
            _iv.image = nil;
            _cb.enabled = YES;
            _tv.text = nil;
            _tvT = nil;

        }
    }];

    
}
#pragma mark -- 生成二维码
- (void)creatQR{
    UIImage *qrImage = [UIImage creatImageWithQrCodeText:self.tvT WithCreatSize:MIN(CGRectGetWidth(_iv.frame),CGRectGetHeight(_iv.frame))];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_iv setImage:qrImage];
    });
    
}
#pragma mark -- 保存图片到相册
- (void)creatSharedPhotoLibrary{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    [PHAssetChangeRequest creationRequestForAssetFromImage:_iv.image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
       // NSCAssert(error == nil, @"保存失败");//调试宏，condition=YES，直接返回，程序继续。condition=NO，抛出异常。
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self deleteKeyBoard];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _iv.image = nil;
    

}
#pragma mark -- 结束键盘
- (void)deleteKeyBoard{
    [self.view endEditing:YES];
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
