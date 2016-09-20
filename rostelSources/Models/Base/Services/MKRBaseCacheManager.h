//
// Created by Anton Zlotnikov on 16.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>


@interface MKRBaseCacheManager : NSObject

- (NSArray *)RLMResultsToNSArray:(RLMResults *)results;

@end