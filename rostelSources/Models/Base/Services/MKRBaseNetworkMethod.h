//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

typedef void(^MKRSuccessBlockHandler)(id returnObject);
typedef void(^MKRFailBlockHandler)(NSError *error, NSArray *serverErrors);


@interface MKRBaseNetworkMethod : NSObject

@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, readonly) RKRequestMethod method;
@property (nonatomic, readonly) RKObjectMapping *mapping;

- (instancetype)initWithUrl:(NSString *)url andMethod:(RKRequestMethod)method andMapping:(RKObjectMapping *)mapping;

- (void)setUpDescriptors;

- (void)setUpResponseInfoDescriptor;

- (void)basicSuccessBlockHandlerWithOperation:(RKObjectRequestOperation *)operation andMappingResult:(RKMappingResult *)mappingResult success:(MKRSuccessBlockHandler)successBlock failure:(MKRFailBlockHandler)failureBlock;

- (void)basicEmptySuccessBlockHandlerWithOperation:(RKObjectRequestOperation *)operation andMappingResult:(RKMappingResult *)mappingResult success:(void (^)())successBlock failure:(MKRFailBlockHandler)failureBlock;

- (void)basicFailureBlockHandlerWithOperation:(RKObjectRequestOperation *)operation andError:(NSError *)error failure:(MKRFailBlockHandler)failureBlock;
@end