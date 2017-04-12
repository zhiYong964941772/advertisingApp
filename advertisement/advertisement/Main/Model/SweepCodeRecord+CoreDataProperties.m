//
//  SweepCodeRecord+CoreDataProperties.m
//  
//
//  Created by huazhan Huang on 2017/3/27.
//
//

#import "SweepCodeRecord+CoreDataProperties.h"

@implementation SweepCodeRecord (CoreDataProperties)

+ (NSFetchRequest<SweepCodeRecord *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SweepCodeRecord"];
}

@dynamic sweepCodeURL;
@dynamic sweepCodeName;
@dynamic sweepCodeTime;
@dynamic sweepCodeImage;

@end
