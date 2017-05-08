//
//  function_LAI_Model.h
//  advertisement
//
//  Created by huazhan Huang on 2017/5/8.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface function_LAI_Model : NSObject
@property (nonatomic, strong)NSMutableArray *subClassArr;

+ (instancetype)shareFunctionModelWithArr:(NSArray*)arr;
@end
@interface functionSubClassModel : NSObject
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *webUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
