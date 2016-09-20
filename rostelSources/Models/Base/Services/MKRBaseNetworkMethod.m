//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRBaseNetworkMethod.h"
#import "MKRResponseInfo.h"
#import "MKRNetworkConfigManager.h"
#import "MKRConsts.h"
#import "NSError+Extension.h"
#import "MKRGlobalErrorsObserver.h"

@interface MKRBaseNetworkMethod()

@property (nonatomic, copy, readwrite) NSString *url;
@property (nonatomic, readwrite) RKRequestMethod method;
@property (nonatomic, readwrite) RKObjectMapping *mapping;

@end

@implementation MKRBaseNetworkMethod {

}

- (instancetype)initWithUrl:(NSString *)url andMethod:(RKRequestMethod)method andMapping:(RKObjectMapping *)mapping{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setUrl:url];
    [self setMethod:method];
    [self setMapping:mapping];
    [self setUpDescriptors];

    return self;
}

- (BOOL)handleAccessTokenInvalidErrorCode:(NSString *)errorCode {
    if (!errorCode) {
        return NO;
    }

    if ([errorCode isEqualToString:ACCESS_TOKEN_INVALID_ERROR_CODE]) {
//        [MKRGlobalErrorsObserver sendGlobalError:[NSError networkErrorWithErrorCode:ACCESS_TOKEN_INVALID_ERROR_CODE]];
        return YES;
    }
    return NO;
}

- (void)setUpDescriptors {
    [self setUpResponseInfoDescriptor];
    if (!self.mapping) {
        return;
    }
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKResponseDescriptor *dataResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
                                                                                                           method:self.method
                                                                                                      pathPattern:self.url
                                                                                                          keyPath:DATA_KEY
                                                                                                      statusCodes:[MKRNetworkConfigManager defaultDescriptorsStatusCodes]];

    [objectManager addResponseDescriptor:dataResponseDescriptor];
}

- (void)setUpResponseInfoDescriptor {
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MKRResponseInfo mapping]
                                                                                            method:self.method
                                                                                       pathPattern:self.url
                                                                                           keyPath:EMPTY_KEY
                                                                                       statusCodes:[MKRNetworkConfigManager defaultDescriptorsStatusCodes]];

    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)basicSuccessBlockHandlerWithOperation:(RKObjectRequestOperation *)operation andMappingResult:(RKMappingResult *)mappingResult success:(MKRSuccessBlockHandler)successBlock
                                                                                                                                      failure:(MKRFailBlockHandler)failureBlock {
    if (!failureBlock) {
        return;
    }
    MKRResponseInfo *responseInfo = [mappingResult.dictionary valueForKey:EMPTY_KEY];
    if (!responseInfo) {
        failureBlock([NSError networkErrorWithErrorCode:UNKNOWN_CONNECTION_ERROR_CODE], nil);
    } else if ([responseInfo.status isEqualToString:SUCCESS_STATUS_CODE]) {
        successBlock([mappingResult.dictionary valueForKey:DATA_KEY]);
    } else {
        failureBlock([NSError networkErrorWithErrorCode:responseInfo.status], responseInfo.errors);
    }
}

- (void)basicEmptySuccessBlockHandlerWithOperation:(RKObjectRequestOperation *)operation andMappingResult:(RKMappingResult *)mappingResult success:(void (^)())successBlock
                                      failure:(MKRFailBlockHandler)failureBlock {
    if (!failureBlock) {
        return;
    }
    MKRResponseInfo *responseInfo = [mappingResult.dictionary valueForKey:EMPTY_KEY];
    if (!responseInfo) {
        failureBlock([NSError networkErrorWithErrorCode:UNKNOWN_CONNECTION_ERROR_CODE], nil);
    } else if ([responseInfo.status isEqualToString:SUCCESS_STATUS_CODE]) {
        successBlock();
    } else {
        failureBlock([NSError networkErrorWithErrorCode:responseInfo.status], responseInfo.errors);
    }
}

- (void)basicFailureBlockHandlerWithOperation:(RKObjectRequestOperation *)operation andError:(NSError *)error failure:(MKRFailBlockHandler)failureBlock {
    MKRResponseInfo *responseInfo = [error.userInfo[RKObjectMapperErrorObjectsKey] firstObject];
    NSError *newError;
    if (!responseInfo) {
        //TODO add other codes?
        if ([error isNoInternetConnectionError]) {
            newError = error;
        } else {
            newError = [NSError networkErrorWithErrorCode:UNKNOWN_CONNECTION_ERROR_CODE];
        }
    } else {
        [self handleAccessTokenInvalidErrorCode:responseInfo.status];
        newError = [NSError networkErrorWithErrorCode:responseInfo.status];
    }
    if (failureBlock) {
        failureBlock(newError, responseInfo.errors);
    }
}

@end