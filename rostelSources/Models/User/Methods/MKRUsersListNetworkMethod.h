//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRUsersListNetworkMethod : MKRBaseNetworkMethod
- (void)usersListWithSuccess:(void (^)(NSArray *usersList))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end