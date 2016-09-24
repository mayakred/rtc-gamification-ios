//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"

@class MKRStrangeObject;


@interface MKRStatsCacheManager : MKRBaseCacheManager

- (void)saveStatsList:(NSArray *)statsList;

- (MKRStrangeObject *)statWithId:(NSNumber *)statId;

- (NSArray *)loadStats;

- (void)clearAllCache;
@end