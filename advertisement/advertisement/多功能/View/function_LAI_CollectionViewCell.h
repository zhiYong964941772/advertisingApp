//
//  function_LAI_CollectionViewCell.h
//  advertisement
//
//  Created by huazhan Huang on 2017/5/3.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface function_LAI_CollectionViewCell : UICollectionViewCell
@property (nonatomic, copy)void (^showFunctionCell)(NSString *text , NSString *imageUrl);
- (void)configureCellWithCellText:(NSString *)text WithImageUrl:(NSString *)imageUrl;
@end
