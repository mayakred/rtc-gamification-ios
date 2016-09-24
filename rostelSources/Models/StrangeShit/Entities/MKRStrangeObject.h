//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRMetric.h"
#import "MKRDepartment.h"


@interface MKRStrangeObject : MKREntityWithId

@property (nonatomic, copy) NSNumber<RLMDouble> *teamValue;
@property (nonatomic, copy) NSNumber<RLMDouble> *participantValue;
@property (nonatomic, copy) NSNumber<RLMDouble> *thresholdValue;
@property (nonatomic, copy) NSNumber<RLMDouble> *winnerValue;
@property (nonatomic, copy) NSNumber<RLMInt> *userId;
@property (nonatomic, copy) NSNumber<RLMBool> *isPerviySubview;
@property (nonatomic, copy) NSNumber<RLMBool> *isVtoroySubview;
@property (nonatomic) MKRDepartment *department;
@property (nonatomic) MKRMetric *metric;

+ (RKObjectMapping *)mapping;
@end