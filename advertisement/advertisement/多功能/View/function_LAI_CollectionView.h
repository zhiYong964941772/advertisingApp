//
//  function_LAI_CollectionVIew.h
//  advertisement
//
//  Created by huazhan Huang on 2017/4/26.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface function_LAI_CollectionView : UICollectionView
+ (__kindof UICollectionView *)getCollection:(CGRect)rect;
- (void)showFunctionCollectionViewWithCellData:(NSArray*)cellData WithHeaderNum:(NSArray*)headerData;
@property (nonatomic, copy)void (^showWeb)(NSString *webUrl);
@end
