//
// Created by Anton Zlotnikov on 04.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRLogoutNetworkMethod : MKRBaseNetworkMethod
- (void)logoutWithSuccess:(void (^)())successBlock failure:(void (^)(NSError *error, NSArray *serverErrors))failureBlock;
@end