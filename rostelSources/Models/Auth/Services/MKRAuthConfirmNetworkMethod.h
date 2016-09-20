//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"

@class MKRAuthCredentials;


@interface MKRAuthConfirmNetworkMethod : MKRBaseNetworkMethod

- (void)authWithPhone:(NSString *)phone andCode:(NSString *)code andSecret:(NSString *)secret
              success:(void (^)(MKRAuthCredentials *authCredentials))successBlock
              failure:(void (^)(NSError *error, NSArray *serverErrors))failureBlock;

@end