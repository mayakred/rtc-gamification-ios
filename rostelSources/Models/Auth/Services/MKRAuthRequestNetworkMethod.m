//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAuthRequestNetworkMethod.h"
#import "MKRAuthSecretKey.h"
#import "MKRResponseInfo.h"
#import "MKRConsts.h"
#import "NSError+Extension.h"
#import "MKRNetworkConfigManager.h"


static NSString *const kMKRAuthPhoneKey = @"phone";

@implementation MKRAuthRequestNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_AUTH_REQUEST andMethod:RKRequestMethodPOST andMapping:[MKRAuthSecretKey mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)sendCodeToPhone:(NSString *)phone success:(void (^)(MKRAuthSecretKey *authSecretKey))successBlock
                failure:(void (^)(NSError *error, NSArray *serverErrors))failureBlock {
    NSParameterAssert(phone);

    [[RKObjectManager sharedManager] postObject:nil path:self.url parameters:@{
            kMKRAuthPhoneKey : phone
    } success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
    }];
}


@end