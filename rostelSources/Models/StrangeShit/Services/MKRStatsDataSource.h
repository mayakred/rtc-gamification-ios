//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRStatsCacheManager;
@class MKRStrangeObject;


@interface MKRStatsDataSource : NSObject
- (instancetype)initWithCacheManager:(MKRStatsCacheManager *)newCacheManager;

- (MKRStrangeObject *)statWithId:(NSNumber *)itemId;

- (NSArray *)statsIdsWithUserId:(NSNumber *)userId andIsIndividual:(BOOL)ind andComparator:(NSComparator)comparator;
@end