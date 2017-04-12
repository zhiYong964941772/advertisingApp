//
//  history_LAI_UITableView.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_UITableView.h"
#import "history_LAI_TableViewCell.h"
@interface history_LAI_UITableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)NSInteger rowNum;
@property (nonatomic ,strong)NSMutableArray *rowList;
@end
@implementation history_LAI_UITableView
#define page 10
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
    self.delegate = self;
    self.dataSource = self;
        self.rowNum = 0;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(firstPage)];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextObject)];
        
    }
    return self;
}
#pragma mark -- 第一页
- (void)firstPage{
   self.rowNum = (self.rowNum>0)?page:0;
}
#pragma mark -- 下一页
- (void)nextPage{
   self.rowNum = (self.rowNum>0)?self.rowNum--:0;

}
- (void)showRowNum{
    [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
        self.rowList = [NSMutableArray arrayWithArray:context.searchObject()];
        if (self.rowList.count) {
            self.rowNum = (self.rowList.count>page)?page:self.rowList.count;
        }
        [self reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    history_LAI_TableViewCell *cell = [history_LAI_TableViewCell getWithTableView:tableView];
    if (indexPath.row<self.rowList.count) {
        cell.historyModel = self.rowList[indexPath.row];//防止越界奔溃
    }
    return cell;
}
@end
