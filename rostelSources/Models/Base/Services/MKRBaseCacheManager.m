//
// Created by Anton Zlotnikov on 16.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRBaseCacheManager.h"


@implementation MKRBaseCacheManager {

}

- (NSArray *)RLMResultsToNSArray:(RLMResults *)results {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    return array;
}

@end