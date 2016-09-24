//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRStatsPresenter.h"
#import "MKRErrorContainer.h"
#import "MKRStrangeObject.h"
#import "MKRAppDataProvider.h"


@implementation MKRStatsPresenter {
    NSNumber *userId;
    NSArray *statsIds;
    BOOL isIndividual;
}

- (instancetype)initWithUserId:(NSNumber *)uId andIsIndividual:(BOOL)ind {
    self = [super init];
    if (!self) {
        return nil;
    }
    userId = uId;
    isIndividual = ind;
    [self loadDuelsIds];
    return self;
}

- (NSNumber *)getUserId {
    return userId;
}

- (void)setIsIndividual:(BOOL)ind {
    isIndividual = ind;
}

- (NSComparator)getComparatorSort {
    return nil;
//    return ^NSComparisonResult(MKRUser *a, MKRUser* b) {
//        return [a.topPosition compare:b.topPosition];
//    };
}

- (void)loadDuelsIds {
    statsIds = [[MKRAppDataProvider shared].statsService statsIdsWithUserId:userId andIsIndividual:isIndividual andComparator:[self getComparatorSort]];
}

- (void)updateStats {
    [[MKRAppDataProvider shared].statsService loadStatsFromServerWithPresenter:self];
}

- (MKRStrangeObject *)statWithIndex:(NSUInteger)index {
    return [[MKRAppDataProvider shared].statsService statWithId:statsIds[index]];
}

- (NSUInteger)statsCount {
    return [statsIds count];
}

- (void)serviceUpdatedStatsListSuccessfully {
    [self loadDuelsIds];
    if (self.delegate) {
        [self.delegate statsListDidUpdateSuccess];
    }
}

- (void)serviceUpdatedStatsListWithError:(MKRErrorContainer *)errorContainer {
    if (self.delegate) {
        [self.delegate statsListDidUpdateWithError:errorContainer];
    }
}

- (void)serviceWillUpdateStatsList {
    if (self.delegate) {
        [self.delegate statsListWillUpdate];
    }
}

@end