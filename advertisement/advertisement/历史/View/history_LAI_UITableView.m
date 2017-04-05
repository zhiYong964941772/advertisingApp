//
//  history_LAI_UITableView.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_UITableView.h"
@interface history_LAI_UITableView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation history_LAI_UITableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self)return self;
    self.delegate = self;
    self.dataSource = self;
    return self;
}

@end
