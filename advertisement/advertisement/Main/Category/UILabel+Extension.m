//
//  UILabel+Extension.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/21.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (instancetype)makeLabelWithBlock:(void(^)(UILabel *label))makeLabel{
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    makeLabel(label);
    return label;
}
- (UILabel *(^)(NSString *))addText{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}
- (UILabel *(^)(CGRect))addFrame{
    return ^(CGRect rect){
        self.frame = rect;
        return self;
    };
}
- (UILabel *(^)(NSTextAlignment))addTextAlignment{
    return ^(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}
- (UILabel *(^)(UIColor *))addTextColor{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
- (UILabel *(^)(CGFloat))addTextFont{
    return ^(CGFloat font){
        self.font = [UIFont systemFontOfSize:font];
        return self;
    };
}
- (UILabel *(^)(UIColor *))addBgColor{
    return ^(UIColor *bgColor){
        self.backgroundColor = bgColor;
        return self;
    };
}
@end
