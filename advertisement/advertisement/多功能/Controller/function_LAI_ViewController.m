//
//  function_LAI_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "function_LAI_ViewController.h"
#import "function_LAI_CollectionView.h"
#import "BaseWebViewController.h"
#import "function_LAI_Model.h"
@interface function_LAI_ViewController ()

@end

@implementation function_LAI_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readData];
}
- (void)readData{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"webLine" ofType:@"plist"];
    NSArray *fileData = [NSArray arrayWithContentsOfFile:filePath];
    function_LAI_Model *model = [function_LAI_Model shareFunctionModelWithArr:fileData];
    function_LAI_CollectionView *FLC = [function_LAI_CollectionView getCollection:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-88)];
    [FLC showFunctionCollectionViewWithCellData:model.subClassArr WithHeaderNum:[fileData lastObject]];
    @weakify(self);
    FLC.showWeb = ^(NSString *webUrl) {
        @strongify(self);
        BaseWebViewController *baseWeb = [BaseWebViewController pushWebVC:webUrl WithIsScan:NO];
        [self.navigationController pushViewController:baseWeb animated:NO];
    };
    [self.view addSubview:FLC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
