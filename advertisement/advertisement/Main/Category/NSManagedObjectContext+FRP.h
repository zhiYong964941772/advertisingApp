//
//  NSManagedObjectContext+FRP.h
//  advertisement
//
//  Created by huazhan Huang on 2017/3/29.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (FRP)

+(NSError *)makeManagedObjectContext:(void(^)(NSManagedObjectContext *context))context;
- (NSManagedObjectContext *(^)(  NSString * name,NSString *url,NSString *time))addObject;
- (NSManagedObjectContext *(^)( NSString * deleteModelName))deleteObject;///<如果传空，那么就会删除所有
- (NSManagedObjectContext *(^)(NSString * changeModelName,NSString *keyChange,NSString *valueChange))changeObject;
- (NSManagedObjectContext *(^)())searchObject;

@end
