//
//  UIImageView+Extension.h
//  advertisement
//
//  Created by huazhan Huang on 2017/5/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
+ (instancetype)makeImageViewWithBlock:(void(^)(UIImageView *imageView))makeImageView;
- (UIImageView *(^)(UIImage *image))addImage;
- (UIImageView *(^)(CGRect rect))addFrame;
- (UIImageView *(^)(UIViewContentMode mode))addContentMode;

@end
