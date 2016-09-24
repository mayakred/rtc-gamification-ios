//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUsersListPresenter.h"
#import "MKRErrorContainer.h"
#import "MKRAppDataProvider.h"


@implementation MKRUsersListPresenter {
    NSArray *usersIds;
    NSString *departmentCode;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    departmentCode = nil;
    [self loadUsersIds];

    return self;
}

- (NSInteger)getPosForUserWithId:(NSNumber *)userId {
    int r = 0;
    for (NSNumber *uId in usersIds) {
        if ([uId isEqualToNumber:userId]) {
            return r;
        }
        r++;
    }
    return -1;
}

- (void)applyDepartmentCode:(NSString *)newDep {
    departmentCode = newDep;
    [self serviceUpdatedUsersListSuccessfully];
}

- (NSComparator)getComparatorSort {
    return ^NSComparisonResult(MKRUser *a, MKRUser* b) {
        return [a.topPosition compare:b.topPosition];
    };
    return nil;
}

- (void)loadUsersIds {
    usersIds = [[MKRAppDataProvider shared].userService usersIdsWithDepartmentCode:departmentCode andComparator:[self getComparatorSort]];
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
