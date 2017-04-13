//
//  history_LAI_UITableView.h
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface history_LAI_UITableView : UITableView
@property (nonatomic, copy)void(^historyWebShow)(NSString *historyUrl);
- (void)showRowNum;
@end
