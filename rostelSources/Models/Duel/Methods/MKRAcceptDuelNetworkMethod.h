//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRAcceptDuelNetworkMethod : MKRBaseNetworkMethod
- (void)acceptDuelWithId:(NSNumber *)duelId success:(void (^)())successBlock failure:(MKRFailBlockHandler)failureBlock;
@end