//
//  history_LAI_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_ViewController.h"
#import "history_LAI_UITableView.h"
@interface history_LAI_ViewController ()


@end

@implementation history_LAI_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [self creatRightButton];
}
- (void)creatTableView{
    history_LAI_UITableView *tableView = [[history_LAI_UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT - 104)];
    [tableView showRowNum];
    [self.view addSubview: tableView];
}
- (void)creatRightButton{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(deleteHistory)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)deleteHistory{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.deleteObject(@"");
        }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
