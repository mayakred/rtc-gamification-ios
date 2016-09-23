//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUsersListPresenter.h"
#import "MKRErrorContainer.h"
#import "MKRAppDataProvider.h"


@implementation MKRUsersListPresenter {
    NSArray *usersIds;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self loadUsersIds];

    return self;
}

- (NSComparator)getComparatorSort {
//    return ^NSComparisonResult(MKRUser *a, MKRUser* b) {
//        return [a.name compare:b.name];
//    };
    return nil;
}

- (void)loadUsersIds {
    usersIds = [[MKRAppDataProvider shared].userService usersIdsWithComparator:[self getComparatorSort]];
}

- (void)updateUsers {
    [[MKRAppDataProvider shared].userService loadUsersListFromServerWithPresenter:self];
}

- (MKRUser *)userWithIndex:(NSUInteger)index {
    if (index >= [usersIds count]) {
        return nil;
    }
    return [[MKRAppDataProvider shared].userService userWithId:usersIds[index]];
}

- (NSUInteger)usersCount {
    return [usersIds count];
}

- (void)serviceUpdatedUsersListSuccessfully {
    [self loadUsersIds];
    if (self.delegate) {
        [self.delegate usersListDidUpdateSuccess];
    }
}

- (void)serviceUpdatedUsersListWithError:(MKRErrorContainer *)errorContainer {
    if (self.delegate) {
        [self.delegate usersListDidUpdateWithError:errorContainer];
    }
}

- (void)serviceWillUpdateUsersList {
    if (self.delegate) {
        [self.delegate usersListWillUpdate];
    }
}

@end