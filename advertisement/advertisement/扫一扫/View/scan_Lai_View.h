//
//  scan_Lai_View.h
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scan_Lai_View : UIView
+(__kindof scan_Lai_View*)shareFactory;
- (void)stopScanning;
@end
