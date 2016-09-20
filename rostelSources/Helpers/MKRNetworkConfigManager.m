//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "MKRNetworkConfigManager.h"
#import "MKRConsts.h"


@implementation MKRNetworkConfigManager {

}

+ (void)setUpConfigs {
    NSLog(@"Set up network client");
    [[AFRKNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    //init client
    NSURL *baseURL = [NSURL URLWithString:SERVER_URL];
    AFRKHTTPClient* client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    [client setDefaultHeader:@"Content-Type" value:@"application/json"];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];

}

+ (void)setAuthHeaderWithToken:(NSString *)authToken {
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSLog(@"Set auth header with token: %@", authToken);
    [objectManager.HTTPClient setAuthorizationHeaderWithToken:authToken];
}

+ (void)clearAuthHeaderToken {
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSLog(@"Clear auth header token");
    [objectManager.HTTPClient clearAuthorizationHeader];
}

+ (NSIndexSet *)defaultDescriptorsStatusCodes {

    //we handle 2**, 4**, 5**
    NSMutableIndexSet *statusCodes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(RKStatusCodeClassSuccessful, 100)];
//    [statusCodes addIndexesInRange:NSMakeRange(RKStatusCodeClassRedirection, 100)];
    [statusCodes addIndexesInRange:NSMakeRange(RKStatusCodeClassClientError, 100)];
    [statusCodes addIndexesInRange:NSMakeRange(RKStatusCodeClassServerError, 100)];
    return statusCodes;
}


@end
