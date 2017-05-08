//
//  function_LAI_CollectionViewCell.m
//  advertisement
//
//  Created by huazhan Huang on 2017/5/3.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "function_LAI_CollectionViewCell.h"
@interface function_LAI_CollectionViewCell()
{
    UILabel *_functionLabel;
    UIImageView *_imageView;
}
@end
@implementation function_LAI_CollectionViewCell
- (void)prepareForReuse{
    [super prepareForReuse];
    _functionLabel.text = nil;
    _imageView.image = nil;
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
          label.addTextFont(12).addTextColor([UIColor blackColor]).addTextAlignment(NSTextAlignmentCenter).addFrame(CGRectMake(0,vH - 30,vW,25));
       }];
      label;
    });
    _imageView = ({
       UIImageView *imageView = [UIImageView makeImageViewWithBlock:^(UIImageView *imageView) {
           imageView.addFrame(CGRectMake(0,0,vW,vH-30)).addContentMode(UIViewContentModeScaleAspectFit);
       }];
        imageView;
    });
    [self.contentView addSubview:_functionLabel];
    [self.contentView addSubview:_imageView];

//    self.showFunctionCell = ^(NSString *text, NSString *imageUrl) {
//           [weakImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageUrl]]];
//           [weakFunctionLabel setText:text];
//    };
}
- (void)configureCellWithCellText:(NSString *)text WithImageUrl:(NSString *)imageUrl{
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageUrl]]];
    [_functionLabel setText:text];

}
@end
