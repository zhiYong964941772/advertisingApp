//
//  setting_Lai_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "setting_Lai_ViewController.h"
#import "setting_Lai_TableView.h"
#import "qrCode_Lai_ViewController.h"
@interface setting_Lai_ViewController ()
@end

@implementation setting_Lai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    setting_Lai_TableView *tableView = [[setting_Lai_TableView alloc]initWithFrame:CGRectMake(0,10,SCREEN_WIDTH, SCREEN_HEIGHT - 98) style:UITableViewStylePlain];
    __weak typeof(tableView)setTab = tableView;
    tableView.showQrV = ^{
        [setTab.signalCreateQrCode subscribeNext:^(id x) {
            [self creatQrCode];
        }];
     
    };
       [self.view addSubview:tableView];
}
- (void)creatQrCode{
    qrCode_Lai_ViewController *qrCode = [[qrCode_Lai_ViewController alloc]init];
    
    [self.navigationController pushViewController:qrCode animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
