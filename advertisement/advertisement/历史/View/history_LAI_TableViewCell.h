//
//  history_LAI_TableViewCell.h
//  advertisement
//
//  Created by huazhan Huang on 2017/4/12.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class history_LAI_model;
@interface history_LAI_TableViewCell : UITableViewCell
@property (nonatomic, strong)history_LAI_model *historyModel;
+ (instancetype)getWithTableView:(UITableView *)tableView;
@end
