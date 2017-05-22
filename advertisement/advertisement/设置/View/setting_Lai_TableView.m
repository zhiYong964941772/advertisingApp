//
//  setting_Lai_TableView.m
//  advertisement
//
//  Created by huazhan Huang on 2017/5/17.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "setting_Lai_TableView.h"
@interface setting_Lai_TableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_textArr;
}
@end
@implementation setting_Lai_TableView
#define ALERTMESSAGES @"相关反馈内容，请发送到作者邮箱（qq964941772@163.com），感谢你的支持！！"
#define APPSTOREID @""
#define APPSCOREURL @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8"
static NSString *Identifier = @"Identifier";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        NSArray *textArr = @[@"生成二维码",@"用户反馈",@"支持我们",@"版本：1.0"];
        _textArr = [NSMutableArray arrayWithArray:textArr];
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _textArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   UILabel *label = [UILabel makeLabelWithBlock:^(UILabel *label) {
       label.addFrame(CGRectMake(0,2,SCREEN_WIDTH,60)).addTextFont(16).addTextColor(BASECOLORL(200, 200, 200)).addTextAlignment(NSTextAlignmentCenter).addText(_textArr[section]).addBgColor(BASECOLORL(150, 150, 150));
       label.clipsToBounds = YES;
       label.layer.cornerRadius = 25;
       label.userInteractionEnabled = YES;
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    switch (section) {
        case 0:
        {
            self.signalCreateQrCode = tap.rac_gestureSignal;
            [label addGestureRecognizer:tap];
            self.showQrV();
        }
            break;
        case 1:
        {
            RACSignal *signal = tap.rac_gestureSignal;
            [label addGestureRecognizer:tap];
            [signal subscribeNext:^(id x) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用户反馈" message:ALERTMESSAGES delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }];

        }
            break;
        case 2:
        {
            RACSignal *signal = tap.rac_gestureSignal;
            [label addGestureRecognizer:tap];
            [signal subscribeNext:^(id x) {
                NSString *scoreUrl = [NSString stringWithFormat:APPSCOREURL,APPSTOREID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scoreUrl]];
            }];

        }
            break;
            
        default:
            break;
    }
    return label;
}
@end
