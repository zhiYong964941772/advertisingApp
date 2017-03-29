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
- (NSManagedObjectContext *(^)(  NSString *key,NSString *value))addObject;
- (NSManagedObjectContext *(^)(NSString *key,NSString *value))deleteObject;
- (NSManagedObjectContext *(^)(NSString *key,NSString *value))changeObject;
- (NSManagedObjectContext *(^)())searchObject;

@end
