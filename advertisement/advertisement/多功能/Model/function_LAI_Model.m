//
//  function_LAI_Model.m
//  advertisement
//
//  Created by huazhan Huang on 2017/5/8.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "function_LAI_Model.h"

@implementation function_LAI_Model
+ (instancetype)shareFunctionModelWithArr:(NSArray *)arr{
    function_LAI_Model *superModel = [[function_LAI_Model alloc]init];
    superModel.subClassArr = [NSMutableArray array];
    for (int i = 0; i<(arr.count-1); i++) {
        NSMutableArray *subClassMax = [NSMutableArray array];
        NSArray *subClassData = arr[i];
        for (int j = 0; j<subClassData.count; j++) {
            functionSubClassModel *subClassModel = [[functionSubClassModel alloc]initWithDic:subClassData[j]];
            [subClassMax addObject:subClassModel];
        }
        [superModel.subClassArr addObject:subClassMax];
    }
    return superModel;
}
@end
@implementation functionSubClassModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.imageUrl = dic[@"webImage"];
        self.text = dic[@"webTitle"];
        self.webUrl = dic[@"webUrl"];
    }
    return self;
}
@end
