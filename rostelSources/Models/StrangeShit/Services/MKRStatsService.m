//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRStatsService.h"
#import "MKRStatsCacheManager.h"
#import "MKRErrorContainer.h"
#import "MKRStatsDataSource.h"
#import "MKRStrangeObject.h"
#import "MKRStatsNetworkMethod.h"
#import "MKRStatsPresenter.h"
#import "MKRStatsPresenter.h"


@implementation MKRStatsService {
    MKRStatsCacheManager *cacheManager;
    MKRStatsDataSource *dataSource;
    MKRStatsNetworkMethod *statsNetworkMethod;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    cacheManager = [[MKRStatsCacheManager alloc] init];
    dataSource = [[MKRStatsDataSource alloc] initWithCacheManager:cacheManager];
    statsNetworkMethod = [[MKRStatsNetworkMethod alloc] init];

    return self;
}

- (void)loadStatsFromServerWithPresenter:(MKRStatsPresenter *)presenter {
    NSLog(@"Start loading stats list");
    NSNumber *userId = [presenter getUserId];
    [presenter serviceWillUpdateStatsList];
    [statsNetworkMethod statsWithUserId:userId success:^(NSArray *statsList) {
        NSLog(@"Success loading stats list");
//        [cacheManager clearCacheForUserId:userId];
        [cacheManager saveStatsList:statsList];
        [presenter serviceUpdatedStatsListSuccessfully];
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error loading stats duels Description:\n%@", error.description);
        [presenter serviceUpdatedStatsListWithError:[MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]];
    }];
}

- (MKRStrangeObject *)statWithId:(NSNumber *)itemId {
    return [dataSource statWithId:itemId];
}

- (NSArray *)statsIdsWithUserId:(NSNumber *)userId andIsIndividual:(BOOL)ind andComparator:(NSComparator)comparator {
    return [dataSource statsIdsWithUserId:userId andIsIndividual:(BOOL)ind andComparator:comparator];
}

- (void)clearAllCache {
    [cacheManager clearAllCache];
}

@end
