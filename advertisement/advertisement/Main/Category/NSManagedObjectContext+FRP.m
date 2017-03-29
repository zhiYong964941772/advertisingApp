//
//  NSManagedObjectContext+FRP.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/29.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "NSManagedObjectContext+FRP.h"
#import "SweepCodeRecord+CoreDataClass.h"
@implementation NSManagedObjectContext (FRP)
+ (NSError *)makeManagedObjectContext:(void (^)(NSManagedObjectContext *))context{
    NSURL *modelPath = [[NSBundle mainBundle]URLForResource:@"advertisementDataModel" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelPath];//建模

    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];//持久化数据库
    
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];//设置数据库路径
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingString:@"/advertisementDataModel.sqlite"]];
    NSError *error = nil;
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];//添加永久化存储库，失败返回空；
    if (!error) {
        NSManagedObjectContext *managed = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        managed.persistentStoreCoordinator = psc;
        context(managed);
        return error;

    }else{
        return error;
    }
}
- (NSManagedObjectContext *(^)(NSString *, NSString *))addObject{
    return ^(NSString *key,NSString *value){
        SweepCodeRecord *mObjc = [NSEntityDescription insertNewObjectForEntityForName:@"SweepCodeRecord" inManagedObjectContext:self];
        if ([key isEqualToString:SAOMAOName]) {
            mObjc.sweepCodeName = value;
        }
        if ([key isEqualToString:SAOMAOTime]) {
            mObjc.sweepCodeTime = value;
        }
        if ([key isEqualToString:SAOMAOURL]) {
            mObjc.sweepCodeURL = value;
        }
        NSError *error = nil;
        [self save:&error];
        return self;
    };
}
- (NSManagedObjectContext *(^)(NSString *, NSString *))deleteObject{
    return ^(NSString *key,NSString *value){
        NSFetchRequest *request = [SweepCodeRecord fetchRequest];//创建请求;
        
        NSPredicate *pdct = [NSPredicate predicateWithFormat:@"%@ = %@",key,value];//创建查询谓语
        request.predicate = pdct;
        NSError *error = nil;
        NSArray *objs = [self executeFetchRequest:request error:&error];
        if (error) {
            [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
        }
        for (SweepCodeRecord *obj in objs) {
            [self deleteObject:obj];
            [self save:&error];
        }
        
        
        return self;
    };
}
- (NSManagedObjectContext *(^)(NSString *, NSString *))changeObject{
    return  ^(NSString *key ,NSString *value){
        NSFetchRequest *request = [SweepCodeRecord fetchRequest];
        [request setFetchLimit:1];
        NSPredicate *pdct = [NSPredicate predicateWithFormat:@"%@ = %@",key,value];
        request.predicate = pdct;
        NSError *error = nil;
        NSArray *objs = [self executeFetchRequest:request error:&error];
        if (!error) {
            for (SweepCodeRecord *obj in objs) {
                if ([key isEqualToString:SAOMAOName]) {
                    obj.sweepCodeName = value;
                }
                if ([key isEqualToString:SAOMAOTime]) {
                    obj.sweepCodeTime = value;
                }
                if ([key isEqualToString:SAOMAOURL]) {
                    obj.sweepCodeURL = value;
                }
                [self save:&error];
            }
        }
        return self;
    };
}
- (NSManagedObjectContext *(^)())searchObject{
    return ^(){
        NSFetchRequest *request = [SweepCodeRecord fetchRequest];//创建请求;默认全查
        
        NSError *error = nil;
        NSArray *objs = [self executeFetchRequest:request error:&error];
        if (!error) {
            for (SweepCodeRecord *obj in objs) {
                NSLog(@"name=%@----url=%@----time=%@",obj.sweepCodeName,obj.sweepCodeURL,obj.sweepCodeTime);
            }
        }

        return self;
    };
}
@end
