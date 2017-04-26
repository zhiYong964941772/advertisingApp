//
//  function_LAI_CollectionVIew.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/26.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "function_LAI_CollectionView.h"
@interface function_LAI_CollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation function_LAI_CollectionView
#define kMagin 10
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}
#pragma mark --  UICollectionViewFlowLayout
- (UICollectionViewFlowLayout *)creatFlowLayout{
    //自动网格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 4 * kMagin) / 3;
    
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    //最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 10;
    //最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 10;
    //设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
    //设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
    flowLayout.headerReferenceSize = CGSizeMake(0,40);
    return flowLayout;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
