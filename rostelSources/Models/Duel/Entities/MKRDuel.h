//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRUser.h"
#import "MKRMetric.h"

@class RKObjectMapping;

@interface MKRDuel : MKREntityWithId

@property (nonatomic, copy) NSNumber<RLMInt> *startAt;
@property (nonatomic, copy) NSNumber<RLMInt> *endAt;
@property (nonatomic, copy) NSNumber<RLMInt> *victimValue;
@property (nonatomic, copy) NSNumber<RLMInt> *initiatorValue;
@property (nonatomic, copy) NSString *status;
@property (nonatomic) MKRUser *initiator;
@property (nonatomic) MKRUser *victim;
@property (nonatomic) MKRMetric *metric;

+ (RKObjectMapping *)mapping;

@end