//
//  scan_Lai_View.h
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scan_Lai_View : UIView
@property (nonatomic, copy) void(^showResults)(UIAlertController* showAV);

+(__kindof scan_Lai_View*)shareFactory;
- (void)stopScanning;
- (void)startScanning;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message sureHandler:(void (^)())sureHandler cancelHandler:(void (^)())cancelHandler;

@end
