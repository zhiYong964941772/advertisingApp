//
//  history_LAI_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//
@import GoogleMobileAds;

#import "history_LAI_ViewController.h"
#import "history_LAI_UITableView.h"
#import "BaseWebViewController.h"
@interface history_LAI_ViewController ()
@property (nonatomic,weak)history_LAI_UITableView *historyTableView;
@property (strong, nonatomic)  GADBannerView *bannerView;

@end

@implementation history_LAI_ViewController
- (GADBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[GADBannerView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 108, SCREEN_WIDTH, 64)];
        _bannerView.adUnitID = @"ca-app-pub-3173484698180136/2506703808";
        [self.view addSubview:_bannerView];
        _bannerView.rootViewController = self;
        
    }
    return _bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [self creatRightButton];
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"ce50569924b7649956ada464f140793a"];
    [self.bannerView loadRequest:request];

}
- (void)creatTableView{
   history_LAI_UITableView *history = [history_LAI_UITableView makeTableView:^(UITableView *tableView) {
         
        [self.view addSubview: tableView];
  
    }];
    self.historyTableView = history;
    @weakify(self);
    history.historyWebShow = ^(NSString *historyUrl) {
    @strongify(self);
        [self showWebWithUrl:historyUrl];
        
    };
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.historyTableView showRowNum];

}
- (void)showWebWithUrl:(NSString *)url{
    BaseWebViewController *baseWeb = [BaseWebViewController pushWebVC:url WithIsScan:NO];
    [self.navigationController pushViewController:baseWeb animated:YES];
}
- (void)creatRightButton{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(deleteHistory)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)deleteHistory{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.deleteObject(@"");
            [self.historyTableView showRowNum];
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
