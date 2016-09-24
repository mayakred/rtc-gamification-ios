//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRStrangeObject;
@class MKRStatsPresenter;

@interface MKRStatsService : NSObject

- (void)loadStatsFromServerWithPresenter:(MKRStatsPresenter *)presenter;

- (MKRStrangeObject *)statWithId:(NSNumber *)itemId;

- (NSArray *)statsIdsWithUserId:(NSNumber *)userId andIsIndividual:(BOOL)ind andComparator:(NSComparator)comparator;

- (void)clearAllCache;
@end