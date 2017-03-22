//
//  ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "ViewController.h"
#import <InMobiSDK/InMobiSDK.h>

@interface ViewController ()<IMBannerDelegate>
@property (weak, nonatomic) IBOutlet IMBanner *bannerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test";
    _bannerView.delegate = self;
    _bannerView.placementId = 1491597165402;
    _bannerView.transitionAnimation = UIViewAnimationTransitionCurlUp;
    [_bannerView shouldAutoRefresh:YES];
    [_bannerView setRefreshInterval:20];
    [_bannerView load];
    
    [_activity startAnimating];
    
}
#pragma mark -- bannerDelegate
-(void)bannerDidFinishLoading:(IMBanner *)banner{
    [_activity stopAnimating];
    
}
- (void)banner:(IMBanner *)banner didFailToLoadWithError:(IMRequestStatus *)error{
    NSString *errorMessage = [NSString stringWithFormat:@"Loading ad  failed. Error code: %ld, message: %@", (long)[error code], [error localizedDescription]];
    NSLog(@"%@", errorMessage);
    
    [_activity stopAnimating];
}
/**
 * The banner was interacted with.
 */
-(void)banner:(IMBanner*)banner didInteractWithParams:(NSDictionary*)params {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"params : %@", params);
}
/**
 * The user would be taken out of the application context.
 */
-(void)userWillLeaveApplicationFromBanner:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
/**
 * The banner would be presenting a full screen content.
 */
-(void)bannerWillPresentScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
/**
 * The banner has finished presenting screen.
 */
-(void)bannerDidPresentScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
/**
 * The banner will start dismissing the presented screen.
 */
-(void)bannerWillDismissScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
/**
 * The banner has dismissed the presented screen.
 */
-(void)bannerDidDismissScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
/**
 * The user has completed the action to be incentivised with.
 */
-(void)banner:(IMBanner*)banner rewardActionCompletedWithRewards:(NSDictionary*)rewards {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"rewards : %@", rewards);
}

@end
