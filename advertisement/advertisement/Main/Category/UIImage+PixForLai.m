//
//  UIImage+PixForLai.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/20.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "UIImage+PixForLai.h"
#define exceptionName @"AlphaPixelsException"
#define exceptionReason @"Unable to allocate memory data"
@implementation UIImage (PixForLai)
- (id)initWithImage:(UIImage *)image{
    int width = image.size.width;
    int height = image.size.height;//获取image参数
    unsigned char *pixelData = malloc(width * height);//创建对应的矩阵
    if (!pixelData) {
        NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:nil];
        @throw exception;//捕获异常
    }
    
    CGContextRef context = CGBitmapContextCreate(pixelData, width, height, 8, width, NULL, kCGImageAlphaOnly);
        
    if (!context) {
        NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:nil];
        @throw exception;//捕获异常
    }
    CGContextDrawImage(context, CGRectMake(0,0,width,height),image.CGImage);
    CGContextRelease(context);
    [self testWithPixelData:pixelData];
    return self;
}
- (void)testWithPixelData:(unsigned char *)pixelData{
    for(int i=0;i<self.size.height;i++)
    {
        for(int y=0;y<self.size.width;y++)
        {
            NSLog(@"0x%X",pixelData[(i*((int)self.size.width))+y]);
        }
    }
}
#pragma mark -- 生成二维码
+ (instancetype)creatImageWithQrCodeText:(NSString *)qrT WithCreatSize:(CGFloat)size{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *filterData = [qrT dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:filterData forKeyPath:@"inputMessage"];
    CIImage *outPutImage = [filter outputImage];
    return [self filterTheQrCode:outPutImage WithSize:size];
}
+ (UIImage *)filterTheQrCode:(CIImage *)ciImage WithSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(ciImage.extent);//获取图片的规格
    CGFloat imageWidth = CGRectGetWidth(extent);
    CGFloat imageHeight = CGRectGetHeight(extent);

    CGFloat scale = MIN(size/imageWidth, size/imageHeight);//计算像素比例
    size_t width = imageWidth*scale;
    size_t height = imageHeight*scale;
    
    CGColorSpaceRef csr = CGColorSpaceCreateDeviceGray();//创建一个颜色空间
    CGContextRef bitMapRef = CGBitmapContextCreate(nil, width, height, 8, 0, csr, kCGImageAlphaNone);//绘制空间的规格
    
    
    CIContext *context = [CIContext contextWithOptions:nil];//获取创建的颜色空间
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];//获取要编辑的过滤图
    
    CGContextSetInterpolationQuality(bitMapRef, kCGInterpolationNone);//连接颜色空间，CGInterpolationQuality表示插入的方式
    
    CGContextScaleCTM(bitMapRef, scale, scale);//更改过滤图的坐标
    
    CGContextDrawImage(bitMapRef, extent, bitmapImage);//重新绘制过滤图
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitMapRef);//按照绘制空间的规格生成新图片
    
    CGContextRelease(bitMapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
  }
@end
