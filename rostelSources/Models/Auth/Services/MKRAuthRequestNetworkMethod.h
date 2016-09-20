//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"

@class MKRAuthSecretKey;


@interface MKRAuthRequestNetworkMethod : MKRBaseNetworkMethod

- (void)sendCodeToPhone:(NSString *)phone success:(void (^)(MKRAuthSecretKey *authSecretKey))successBlock
                failure:(void (^)(NSError *error, NSArray *serverErrors))failureBlock;


@end