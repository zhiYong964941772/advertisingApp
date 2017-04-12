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
#pragma mark -- 增加表
- (NSManagedObjectContext *(^)(NSString * ,NSString *,NSData *))addObject{
    return ^(NSString *name,NSString *url,NSData *image){
        SweepCodeRecord *mObjc = [NSEntityDescription insertNewObjectForEntityForName:@"SweepCodeRecord" inManagedObjectContext:self];
            mObjc.sweepCodeName = name;
            mObjc.sweepCodeTime = [self getDate];
            mObjc.sweepCodeURL = url;
            mObjc.sweepCodeImage = image;
        NSError *error = nil;
        [self save:&error];
        return self;
    };
}
#pragma mark -- 删除某一个表
- (NSManagedObjectContext *(^)(NSString * ))deleteObject{
    return ^(NSString *deleteModelName){
        NSFetchRequest *request = [SweepCodeRecord fetchRequest];//创建请求;
        
        if (deleteModelName.length>0||[deleteModelName isEqualToString:@"(null)"]) {
            NSPredicate *pdct = [NSPredicate predicateWithFormat:@"sweepCodeName=%@",deleteModelName];//创建查询谓语
            request.predicate = pdct;
        }
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
#pragma mark -- 修改表
- (NSManagedObjectContext *(^)(NSString * ,NSString *,id,NSData *))changeObject{
    return  ^(NSString *changeModelName,NSString *keyChange,id valueChange,NSData *imageChange){
        NSFetchRequest *request = [SweepCodeRecord fetchRequest];
        [request setFetchLimit:1];
        NSPredicate *pdct = [NSPredicate predicateWithFormat:@"sweepCodeName=%@",changeModelName];
        request.predicate = pdct;
        NSError *error = nil;
        NSArray *objs = [self executeFetchRequest:request error:&error];
        if (!error) {
            for (SweepCodeRecord *obj in objs) {
                if ([keyChange isEqualToString:SAOMAOName]) {
                    obj.sweepCodeName = valueChange;
                }
                if ([keyChange isEqualToString:SAOMAOURL]) {
                    obj.sweepCodeURL = valueChange;
                }
                if ([keyChange isEqualToString:SAOMAOTime]) {
                    obj.sweepCodeTime = valueChange;
                }
                if ([keyChange isEqualToString:SAOMAOImage]) {
                    obj.sweepCodeImage = valueChange;
                }

                [self save:&error];
            }
        }
        return self;
    };
}
#pragma mark -- 查询表
- (NSArray *(^)())searchObject{
    return ^(){
        NSFetchRequest *request = [SweepCodeRecord fetchRequest];//创建请求;默认全查
        
        NSError *error = nil;
        NSArray *objs = [self executeFetchRequest:request error:&error];
        if (!error) {
            return objs;

        }
        return [NSArray array];

    };
}
#pragma mark -- 判断表是否存在
- (BOOL)queryTableExists:(NSString *)searchName{
    NSFetchRequest *request = [SweepCodeRecord fetchRequest];//创建请求;默认全查
    NSPredicate *pdct = [NSPredicate predicateWithFormat:@"sweepCodeName=%@",searchName];
    request.predicate = pdct;
    NSError *error = nil;
    NSArray *objs = [self executeFetchRequest:request error:&error];
    if (objs.count) {
        return YES;
    }
    return NO;

}
#pragma mark -- 获取当前时间
- (NSString *)getDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}
@end
