//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuelsListPresenter.h"
#import "MKRAppDataProvider.h"
#import "MKRErrorContainer.h"
#import "MKRDuel.h"


@implementation MKRDuelsListPresenter {
    NSArray *duelsIds;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self loadDuelsIds];

    return self;
}

- (NSComparator)getComparatorSort {
    return ^NSComparisonResult(MKRDuel *a, MKRDuel* b) {
        return [b.startAt compare:a.startAt];
    };
}

- (void)loadDuelsIds {
    duelsIds = [[MKRAppDataProvider shared].duelsService duelsIdsWithComparator:[self getComparatorSort]];
}

- (void)updateDuels {
    [[MKRAppDataProvider shared].duelsService loadDuelsListFromServerWithPresenter:self];
}

- (MKRDuel *)duelWithIndex:(NSUInteger)index {
    if (index >= [duelsIds count]) {
        return nil;
    }
    return [[MKRAppDataProvider shared].duelsService duelWithId:duelsIds[index]];
}

- (NSUInteger)duelsCount {
    return [duelsIds count];
}

- (void)serviceUpdatedDuelsListSuccessfully {
    [self loadDuelsIds];
    if (self.delegate) {
        [self.delegate duelsListDidUpdateSuccess];
    }
}

- (void)serviceUpdatedDuelsListWithError:(MKRErrorContainer *)errorContainer {
    if (self.delegate) {
        [self.delegate duelsListDidUpdateWithError:errorContainer];
    }
}

- (void)serviceWillUpdateDuelsList {
    if (self.delegate) {
        [self.delegate duelsListWillUpdate];
    }
}

@end