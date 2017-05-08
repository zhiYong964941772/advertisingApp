//
//  function_LAI_CollectionReusableView.h
//  advertisement
//
//  Created by huazhan Huang on 2017/5/8.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface function_LAI_CollectionReusableView : UICollectionReusableView
@property (nonatomic, copy)void (^showFunctionHeader)(NSString *webTitle);

@end
