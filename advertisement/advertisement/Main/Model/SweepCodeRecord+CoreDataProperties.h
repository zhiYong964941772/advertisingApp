//
//  SweepCodeRecord+CoreDataProperties.h
//  
//
//  Created by huazhan Huang on 2017/3/27.
//
//

#import "SweepCodeRecord+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SweepCodeRecord (CoreDataProperties)

+ (NSFetchRequest<SweepCodeRecord *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *sweepCodeURL;
@property (nullable, nonatomic, copy) NSString *sweepCodeName;
@property (nullable, nonatomic, copy) NSString *sweepCodeTime;
@property (nullable, nonatomic, copy) NSData *sweepCodeImage;

@end

NS_ASSUME_NONNULL_END
