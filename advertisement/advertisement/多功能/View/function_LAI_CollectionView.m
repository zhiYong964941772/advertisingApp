//
//  function_LAI_CollectionVIew.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/26.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "function_LAI_CollectionView.h"
#import "function_LAI_CollectionViewCell.h"
#import "function_LAI_CollectionReusableView.h"
#import "function_LAI_Model.h"
@interface function_LAI_CollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _cellNum;//cell的行数
    NSInteger _headerNum;//头的个数
    NSMutableArray *_cellData;//cell的数据
    NSArray *_headerData;//表头的数据

}
@end
@implementation function_LAI_CollectionView
static CGFloat cellHeight;//cell的高度
static NSString *const FUNCTIONIDENTIFIERCELL = @"FUNCTIONIDENTIFIER";//重用关键字
static NSString *const FUNCTIONIDENTIFIERHEADER = @"FUNCTIONIDENTIFIERHEADER";//

#define kMagin 10
+ (UICollectionView *)getCollection:(CGRect)rect{
    return [[self alloc]initWithFrame:rect collectionViewLayout:[self creatFlowLayout]];
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[function_LAI_CollectionViewCell class] forCellWithReuseIdentifier:FUNCTIONIDENTIFIERCELL];
        [self registerClass:[function_LAI_CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FUNCTIONIDENTIFIERHEADER];
    }
    return self;
}
#pragma mark -- 展示view
- (void)showFunctionCollectionViewWithCellData:(NSMutableArray *)cellData WithHeaderNum:(NSArray *)headerData{
    _cellData = cellData;
    _headerData = headerData;
    _headerNum = _headerData.count;

    [self reloadData];
    
}
#pragma mark --  UICollectionViewFlowLayout
+ (UICollectionViewFlowLayout *)creatFlowLayout{
    //自动网格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 6 * kMagin) / 3;
    cellHeight = itemWidth;
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return (_headerNum&&_headerNum>0)?_headerNum:0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *cellArr = _cellData[section];
    _cellNum = cellArr.count;
    return (_cellNum&&_cellNum>0)?_cellNum:0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    function_LAI_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FUNCTIONIDENTIFIERCELL forIndexPath:indexPath];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    functionSubClassModel *model = _cellData[indexPath.section][indexPath.row];
//    ((function_LAI_CollectionViewCell *)cell).showFunctionCell(model.text, model.imageUrl);
    [((function_LAI_CollectionViewCell *)cell) configureCellWithCellText:model.text WithImageUrl:model.imageUrl];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    functionSubClassModel *model = _cellData[indexPath.section][indexPath.row];
    self.showWeb(model.webUrl);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    function_LAI_CollectionReusableView *reusableView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FUNCTIONIDENTIFIERHEADER forIndexPath:indexPath];
        
        reusableView.showFunctionHeader(_headerData[indexPath.section]);
        
    }
    return reusableView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
