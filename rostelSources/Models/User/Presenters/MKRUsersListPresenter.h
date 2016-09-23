//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRUser.h"

@class MKRErrorContainer;


@protocol MKRUsersListDataDelegate <NSObject>
@required
- (void)citiesListDidUpdateSuccess;
- (void)citiesListDidUpdateWithError:(MKRErrorContainer *)errorContainer;
- (void)citiesListWillUpdate;
@end

@interface MKRUsersListPresenter : NSObject

@property (nonatomic, weak) id <MKRUsersListDataDelegate> delegate;

- (void)updateUsers;
- (MKRUser *)usersWithIndex:(NSUInteger)index;
- (NSUInteger)usersCount;

- (void)serviceUpdatedUsersListSuccessfully;
- (void)serviceUpdatedUsersListWithError:(MKRErrorContainer *)errorContainer;
- (void)serviceWillUpdateUsersList;

@end