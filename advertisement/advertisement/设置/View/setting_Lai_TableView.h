//
//  setting_Lai_TableView.h
//  advertisement
//
//  Created by huazhan Huang on 2017/5/17.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setting_Lai_TableView : UITableView
@property (nonatomic, strong)RACSignal *signalCreateQrCode;
@property (nonatomic, copy)void (^showQrV)();
@end
