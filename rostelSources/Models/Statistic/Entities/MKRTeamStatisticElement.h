//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "MKRMetric.h"

@class RKObjectMapping;

@interface MKRTeamStatisticElement : RLMObject

@property (nonatomic, strong) NSNumber<RLMDouble> *teamValue;
@property (nonatomic, strong) NSNumber<RLMDouble> *thresholdValue;
@property (nonatomic, strong) NSNumber<RLMDouble> *winnerValue;
@property (nonatomic) MKRMetric *metric;

+ (RKObjectMapping *)mapping;

@end

RLM_ARRAY_TYPE(MKRTeamStatisticElement)