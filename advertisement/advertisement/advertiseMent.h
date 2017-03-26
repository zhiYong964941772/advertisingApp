//
//  advertiseMent.h
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#ifndef advertiseMent_h
#define advertiseMent_h

#define INMOBI_INITIALIZE @"1ebda88754444314a57c005780579831"//应用码
#define INMOBI_placementId 1491597165402//广告识别id
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define DEVICE(version)  ([[[UIDevice currentDevice] systemVersion] floatValue] >=version)
#define BASECOLORLA(r,g,b,A) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:A]
#define BASECOLORL(r,g,b) BASECOLORLA(r,g,b,1.0)
#define NSNOTIFICATION [NSNotificationCenter defaultCenter]
#define NSUSERDEFAULTS [NSUserDefaults standardUserDefaults]
#define HomeDirectory [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define SS(type) __strong typeof(type) strong##type = type
#define WS(type) __weak typeof(type) weak##type = type

#define ZHI_NSNotificationCenter [NSNotificationCenter defaultCenter]

#endif /* advertiseMent_h */
