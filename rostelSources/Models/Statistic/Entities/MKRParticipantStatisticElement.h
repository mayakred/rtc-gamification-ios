//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "MKRMetric.h"

@interface MKRParticipantStatisticElement : RLMObject


@property (nonatomic, copy) NSNumber<RLMDouble> *participantValue;
@property (nonatomic, copy) NSNumber<RLMDouble> *teamValue;
@property (nonatomic, copy) NSNumber<RLMDouble> *thresholdValue;
@property (nonatomic, copy) NSNumber<RLMDouble> *winnerValue;
@property (nonatomic) MKRMetric *metric;

+ (RKObjectMapping *)mapping;

@end

RLM_ARRAY_TYPE(MKRParticipantStatisticElement)