//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAuthConfirmNetworkMethod.h"
#import "MKRAuthCredentials.h"
#import "MKRResponseInfo.h"
#import "MKRConsts.h"
#import "NSError+Extension.h"
#import "MKRNetworkConfigManager.h"
#import "MKRUtils.h"
#import <CocoaSecurity/CocoaSecurity.h>

static NSString *const kMKRAuthPhoneKey    = @"phone";
static NSString *const kMKRAuthPlatformKey = @"platform";
static NSString *const kMKRAuthDeviceIdKey = @"device_id";
static NSString *const kMKRAuthPasswordKey = @"password";

@implementation MKRAuthConfirmNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_AUTH_CONFIRM andMethod:RKRequestMethodPOST andMapping:[MKRAuthCredentials mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)authWithPhone:(NSString *)phone andCode:(NSString *)code andSecret:(NSString *)secret
              success:(void (^)(MKRAuthCredentials *authCredentials))successBlock
              failure:(void (^)(NSError *error, NSArray *serverErrors))failureBlock {
    NSParameterAssert(phone);
    NSParameterAssert(code);
    NSParameterAssert(secret);

    CocoaSecurityResult *passwordSha256 = [CocoaSecurity sha256:[code stringByAppendingString:secret]];
    NSString *password = [passwordSha256 hexLower];

    [[RKObjectManager sharedManager] postObject:nil path:API_AUTH_CONFIRM parameters:@{
            kMKRAuthPhoneKey     : phone,
            kMKRAuthPlatformKey  : PLATFORM,
            kMKRAuthDeviceIdKey  : [MKRUtils deviceId],
            kMKRAuthPasswordKey  : password
    } success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
    }];
}

@end