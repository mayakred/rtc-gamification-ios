//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"

@class MKRDuel;


@interface MKRDuelsCacheManager : MKRBaseCacheManager
- (void)saveDuelsList:(NSArray *)usersList;

- (MKRDuel *)duelWithId:(NSNumber *)duelId;

- (NSArray *)loadDuelsList;

- (void)clearAllCache;
@end