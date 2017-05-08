//
//  UIImageView+Extension.m
//  advertisement
//
//  Created by huazhan Huang on 2017/5/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
+ (instancetype)makeImageViewWithBlock:(void (^)(UIImageView *))makeImageView{
    UIImageView *imageView = [[UIImageView alloc]init];
    makeImageView(imageView);
    return imageView;
}
- (UIImageView *(^)(UIImage *))addImage{
    return ^(UIImage *image){
        [self setImage:image];
        return self;
    };
}
- (UIImageView *(^)(CGRect))addFrame{
    return ^(CGRect frame){
        [self setFrame:frame];
        return self;
    };
}
- (UIImageView *(^)(UIViewContentMode))addContentMode{
    return ^(UIViewContentMode contentMode){
        [self setContentMode:contentMode];
        return self;
    };
}
@end
