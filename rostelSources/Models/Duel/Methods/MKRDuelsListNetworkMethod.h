//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRDuelsListNetworkMethod : MKRBaseNetworkMethod
- (void)duelsListWithSuccess:(void (^)(NSArray *usersList))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end