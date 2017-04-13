//
//  UITableView+LZY.h
//  advertisement
//
//  Created by huazhan Huang on 2017/4/13.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LZY)
+(__kindof UITableView*)makeTableView:(void(^)(UITableView *tableView))tableView;
@end
