//
//  BaseWebViewController.h
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController

+ (BaseWebViewController *)pushWebVC:(NSString *)urlStr;
- (BaseWebViewController *)tipsUrl:(void(^)(NSString *str))urlStr;
@end
