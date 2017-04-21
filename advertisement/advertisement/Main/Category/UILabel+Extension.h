//
//  UILabel+Extension.h
//  advertisement
//
//  Created by huazhan Huang on 2017/4/21.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UILabel (Extension)
+ (instancetype)makeLabelWithBlock:(void(^)(UILabel *label))makeLabel;
- ( UILabel * (^)(NSString *text))addText;
- ( UILabel * (^)(CGRect rect))addFrame;
- ( UILabel * (^)(NSTextAlignment alignment))addTextAlignment;
- ( UILabel * (^)(UIColor *color))addTextColor;
- ( UILabel * (^)(CGFloat font))addTextFont;
- ( UILabel * (^)(UIColor *bgColor))addBgColor;

@end
