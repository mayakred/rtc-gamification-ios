//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuelsService.h"
#import "MKRDuelsListNetworkMethod.h"
#import "MKRDuelsCacheManager.h"
#import "MKRDuel.h"
#import "MKRDuelsDataSource.h"
#import "MKRDuelsListPresenter.h"
#import "MKRErrorContainer.h"
#import "MKRDuelsListPresenter.h"


@implementation MKRDuelsService {
    MKRDuelsListNetworkMethod *duelsListNetworkMethod;
    MKRDuelsCacheManager *cacheManager;
    MKRDuelsDataSource *dataSource;
}


- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    duelsListNetworkMethod = [[MKRDuelsListNetworkMethod alloc] init];
    cacheManager = [[MKRDuelsCacheManager alloc] init];
    dataSource = [[MKRDuelsDataSource alloc] initWithCacheManager:cacheManager];

    return self;
}

- (void)loadDuelsListFromServerWithPresenter:(MKRDuelsListPresenter *)presenter {
    NSLog(@"Start loading duels list");
    [presenter serviceWillUpdateDuelsList];
    [duelsListNetworkMethod duelsListWithSuccess:^(NSArray *duelsList) {
        NSLog(@"Success loading duels list");
        [cacheManager clearAllCache];
        [cacheManager saveDuelsList:duelsList];
        [presenter serviceUpdatedDuelsListSuccessfully];
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error loading users duels Description:\n%@", error.description);
        [presenter serviceUpdatedDuelsListWithError:[MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]];
    }];
}

- (MKRDuel *)duelWithId:(NSNumber *)itemId {
    return [dataSource duelWithId:itemId];
}

- (NSArray *)duelsIdsWithComparator:(NSComparator)comparator {
    return [dataSource duelsIdsWithComparator:comparator];
}


@end