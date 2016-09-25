//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRUserMetricValue;


@protocol MKRUsersMetricsDataDelegate <NSObject>
@required
- (void)metricsListDidUpdateSuccess;
- (void)metricsListDidUpdateWithError:(MKRErrorContainer *)errorContainer;
- (void)metricsListWillUpdate;
@end


@interface MKRUsersMetricsPresenter : NSObject

@property (nonatomic, weak) id <MKRUsersMetricsDataDelegate> delegate;

- (instancetype)initWitIsPerviySubview:(BOOL)pS andMetricCode:(NSString *)mCode;

- (BOOL)getIsPerviySubview;

- (NSString *)getMetricCode;

- (void)loadUsersMetricsIds;

- (void)updateUsersMetrics;

- (MKRUserMetricValue *)userMetricWithIndex:(NSUInteger)index;

- (NSUInteger)usersMetricsCount;

- (void)serviceUpdatedMetricsListSuccessfully;

- (void)serviceUpdatedMetricsListWithError:(MKRErrorContainer *)errorContainer;

- (void)serviceWillUpdateMetricsList;

@end