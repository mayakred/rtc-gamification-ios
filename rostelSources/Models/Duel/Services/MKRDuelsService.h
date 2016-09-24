//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRDuel;
@class MKRDuelsListPresenter;


@interface MKRDuelsService : NSObject
- (void)loadDuelsListFromServerWithPresenter:(MKRDuelsListPresenter *)presenter;

- (MKRDuel *)duelWithId:(NSNumber *)itemId;

- (NSArray *)duelsIdsWithComparator:(NSComparator)comparator;
@end