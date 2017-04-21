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
@end
