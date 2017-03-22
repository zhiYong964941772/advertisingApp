//
//  HWTabBarViewController.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWNavigationController.h"
#import "game_Lai_ViewController.h"
#import "history_LAI_ViewController.h"
#import "scan_Lai_ViewController.h"
#import "function_LAI_ViewController.h"
#import "setting_Lai_ViewController.h"
#import "HWTabBar.h"
@interface HWTabBarViewController () <HWTabBarDelegate>

@end

@implementation HWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化子控制器
    game_Lai_ViewController *home = [[game_Lai_ViewController alloc] init];
    [self addChildVc:home title:@"小游戏" image:@"海量游戏" selectedImage:@"海量游戏"];
    
    history_LAI_ViewController *messageCenter = [[history_LAI_ViewController alloc] init];
    [self addChildVc:messageCenter title:@"记录" image:@"历史" selectedImage:@"历史"];
    
    function_LAI_ViewController *profile = [[function_LAI_ViewController alloc] init];
    [self addChildVc:profile title:@"便捷" image:@"应用功能" selectedImage:@"应用功能"];
    
    setting_Lai_ViewController *discover = [[setting_Lai_ViewController alloc] init];
    [self addChildVc:discover title:@"设置" image:@"设置" selectedImage:@"设置"];
    // 2.更换系统自带的tabbar
    HWTabBar *tabBar = [[HWTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HWTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;

     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = BASECOLORL(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = BASECOLORL(211, 25, 6);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark - HWTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar
{
    scan_Lai_ViewController *vc = [[scan_Lai_ViewController alloc] init];
    HWNavigationController *navi = [[HWNavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:navi animated:YES completion:nil];
}

@end
