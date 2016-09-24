//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRStrangeObject;

@protocol MKRStatsListDataDelegate <NSObject>
@required
- (void)statsListDidUpdateSuccess;
- (void)statsListDidUpdateWithError:(MKRErrorContainer *)errorContainer;
- (void)statsListWillUpdate;
@end

@interface MKRStatsPresenter : NSObject

@property (nonatomic, weak) id <MKRStatsListDataDelegate> delegate;

- (instancetype)initWithUserId:(NSNumber *)uId andIsIndividual:(BOOL)ind;

- (NSNumber *)getUserId;

- (void)setIsIndividual:(BOOL)ind;

- (void)loadDuelsIds;

- (void)updateStats;

- (MKRStrangeObject *)statWithIndex:(NSUInteger)index;

- (NSUInteger)statsCount;

- (void)serviceUpdatedStatsListSuccessfully;

- (void)serviceUpdatedStatsListWithError:(MKRErrorContainer *)errorContainer;

- (void)serviceWillUpdateStatsList;

@end