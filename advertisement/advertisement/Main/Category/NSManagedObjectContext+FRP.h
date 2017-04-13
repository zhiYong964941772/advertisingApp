//
//  NSManagedObjectContext+FRP.h
//  advertisement
//
//  Created by huazhan Huang on 2017/3/29.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (FRP)
+(NSError *)makeManagedObjectContext:(void(^)(NSManagedObjectContext *context))context;//创建数据库
- (NSManagedObjectContext *(^)( NSString * name,NSString *url,NSData *image))addObject;//添加表
- (NSManagedObjectContext *(^)( NSString * deleteModelName))deleteObject;///<如果传空，那么就会删除所有
- (NSManagedObjectContext *(^)(NSString * changeModelName,NSString *keyChange,id,NSData *imageChange))changeObject;//修改对应的表
- (NSArray *(^)())searchObject;//查询表内容
- (BOOL)queryTableExists:(NSString *)searchName;//查询表是否存在

@end
