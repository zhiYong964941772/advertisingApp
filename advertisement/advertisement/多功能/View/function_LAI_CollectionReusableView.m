//
//  function_LAI_CollectionReusableView.m
//  advertisement
//
//  Created by huazhan Huang on 2017/5/8.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "function_LAI_CollectionReusableView.h"
@interface function_LAI_CollectionReusableView()
{
    UILabel *_functionLabel;

}
@end
@implementation function_LAI_CollectionReusableView
- (void)prepareForReuse{
    [super prepareForReuse];
    _functionLabel.text = nil;

}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatViewLayout];
    }
    return self;
}
- (void)creatViewLayout{
    CGFloat vH = self.height;
    CGFloat vW = self.width;
    _functionLabel = ({
        UILabel *label = [UILabel makeLabelWithBlock:^(UILabel *label) {
            label.addTextFont(12).addBgColor([UIColor whiteColor]).addTextAlignment(NSTextAlignmentCenter).addFrame(CGRectMake(0,vH - 30,vW,25));
        }];
        [self addSubview:label];
        label;
    });
    __weak typeof(_functionLabel)weakFunctionLabel = _functionLabel;
    
    self.showFunctionHeader  = ^(NSString *webTitle) {
        [weakFunctionLabel setText:webTitle];
    };
}

@end
