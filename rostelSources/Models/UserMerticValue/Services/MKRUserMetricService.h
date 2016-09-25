//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRUserMetricValue;
@class MKRUsersMetricsPresenter;


@interface MKRUserMetricService : NSObject
- (void)loadMetricsListFromServerWithPresenter:(MKRUsersMetricsPresenter *)presenter;

- (NSArray *)usersMetricsIdsWithPerviySubview:(BOOL)perviySubiew andComparator:(NSComparator)comparator;

- (MKRUserMetricValue *)userMetricWithId:(NSNumber *)itemId;
@end