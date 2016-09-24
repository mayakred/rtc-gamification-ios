//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRDuel;
@class MKRDuelsListPresenter;
@class MKRErrorContainer;


#define DUEL_STATUS_WAITING_VICTIM @"duel_status_type.waiting_victim"
#define DUEL_STATUS_IN_PROGRESS @"duel_status_type.in_progress"
#define DUEL_STATUS_WICTIM_WIN @"duel_status_type.victim_win"
#define DUEL_STATUS_INITIATOR_WIN @"duel_status_type.initiator_win"
#define DUEL_STATUS_DRAW @"duel_status_type.draw"
#define DUEL_STATUS_REJECTED_BY_VICTIM @"duel_status_type.rejected_by_victim"

@interface MKRDuelsService : NSObject
- (void)loadDuelsListFromServerWithPresenter:(MKRDuelsListPresenter *)presenter;

- (void)acceptDuelWithId:(NSNumber *)duelId success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)declineDuelWithId:(NSNumber *)duelId success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (MKRDuel *)duelWithId:(NSNumber *)itemId;

- (NSArray *)duelsIdsWithComparator:(NSComparator)comparator;

- (void)clearAllCache;
@end