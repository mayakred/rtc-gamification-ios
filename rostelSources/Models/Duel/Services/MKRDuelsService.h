//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRDuel;
@class MKRDuelsListPresenter;
@class MKRErrorContainer;


@interface MKRDuelsService : NSObject
- (void)loadDuelsListFromServerWithPresenter:(MKRDuelsListPresenter *)presenter;

- (void)acceptDuelWithId:(NSNumber *)duelId success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)declineDuelWithId:(NSNumber *)duelId success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (MKRDuel *)duelWithId:(NSNumber *)itemId;

- (NSArray *)duelsIdsWithComparator:(NSComparator)comparator;
@end