//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRUser.h"

@class MKRErrorContainer;


@protocol MKRUsersListDataDelegate <NSObject>
@required
- (void)usersListDidUpdateSuccess;
- (void)usersListDidUpdateWithError:(MKRErrorContainer *)errorContainer;
- (void)usersListWillUpdate;
@end

@interface MKRUsersListPresenter : NSObject

@property (nonatomic, weak) id <MKRUsersListDataDelegate> delegate;

- (NSInteger)getPosForUserWithId:(NSNumber *)userId;

- (void)applyDepartmentCode:(NSString *)newDep;

- (void)updateUsers;
- (MKRUser *)userWithIndex:(NSUInteger)index;
- (NSUInteger)usersCount;

- (void)serviceUpdatedUsersListSuccessfully;
- (void)serviceUpdatedUsersListWithError:(MKRErrorContainer *)errorContainer;
- (void)serviceWillUpdateUsersList;

@end