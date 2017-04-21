//
//  history_LAI_UITableView.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/5.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_UITableView.h"
#import "history_LAI_TableViewCell.h"
#import "SweepCodeRecord+CoreDataProperties.h"
#import "history_LAI_model.h"
@interface history_LAI_UITableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)NSInteger rowNum;
@property (nonatomic ,strong)NSMutableArray *rowList;
@end
@implementation history_LAI_UITableView
#define page 10
#define cellHeight 88
+(UITableView *)makeTableView:(void (^)(UITableView *))tableView{
    history_LAI_UITableView *HL = [[history_LAI_UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 88)];
    tableView(HL);
    return HL;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowNum = 0;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(firstPage)];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextPage)];
        
    }
    return self;
}
#pragma mark -- 第一页，默认十条
- (void)firstPage{
   self.rowNum = (self.rowList.count>page)?page:self.rowList.count;
    [self refreshReloadTableView];

}
#pragma mark -- 加载剩余的
- (void)nextPage{
    NSInteger i = page + 10;
    NSInteger count = self.rowList.count;
    self.rowNum = (i > count)?count:i;
    [self refreshReloadTableView];
}
#pragma mark -- 结束刷新，并更新UI
- (void)refreshReloadTableView{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [self reloadData];
}
#pragma mark -- 更新tableView
- (void)showRowNum{
    [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
        self.rowList = [NSMutableArray new];
        NSArray *arr = context.searchObject();//coredata恶心的机制，二次读取数据库会变更数据地址所以第一次要赋值数据保存
        for (SweepCodeRecord *model in arr) {
            history_LAI_model *historyModel = [[history_LAI_model alloc]init];
            historyModel.url = model.sweepCodeURL;
            historyModel.name = model.sweepCodeName;
            historyModel.time = model.sweepCodeTime;
            historyModel.imageData = model.sweepCodeImage;
            [self.rowList addObject:historyModel];
        }
        if (self.rowList.count) {
            self.rowNum = (self.rowList.count>page)?page:self.rowList.count;
        }
        
        [self reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    history_LAI_TableViewCell *cell = [history_LAI_TableViewCell getWithTableView:tableView];
    
    if (indexPath.row<self.rowList.count) {
        cell.historyModel = self.rowList[indexPath.row];//防止越界奔溃
        cell.showsReorderControl =YES;//打开可操作按钮

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *header = [UILabel makeLabelWithBlock:^(UILabel *label) {
        label.addFrame(CGRectMake(0,0,SCREEN_WIDTH,40)).addTextFont(14).addTextAlignment(NSTextAlignmentCenter).addBgColor(BASECOLORL(230,230,230)).addText(@"温馨提示，左滑删除历史记录");
    }];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        history_LAI_model *historModel = self.rowList[indexPath.row];
        [self.rowList removeObjectAtIndex:indexPath.row];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.rowNum = (self.rowNum>0)?self.rowNum-- : 0;
            [self reloadData];
            [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
                context.deleteObject(historModel.name);
            }];
 
        });
        
        }
        
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.historyWebShow) {
        history_LAI_model *model = self.rowList[indexPath.row];
        
        self.historyWebShow(model.url);

    }
}
@end
