//
//  HWTextView.m
//  黑马微博2期
//
//  Created by imac on 15/10/20.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWTextView.h"

@implementation HWTextView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [ZHI_NSNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)textDidChange{
    
    [self setNeedsDisplay];
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
- (void)setPlacholColor:(UIColor *)placholColor{
    _placholColor = placholColor;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    if (self.hasText) return;
    CGFloat w = rect.size.width - 2*5;
    CGFloat h = rect.size.height - 2*8;
    CGRect placeholdRect = CGRectMake(5, 8, w, h);
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.font;
    attr[NSForegroundColorAttributeName] = self.placholColor?self.placholColor:[UIColor grayColor];
    [self.placeholder drawInRect:placeholdRect withAttributes:attr];
}
- (void)dealloc{
    [ZHI_NSNotificationCenter removeObserver:self];
}

@end
