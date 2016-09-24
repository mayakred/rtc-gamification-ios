//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"

@class RKObjectMapping;

@interface MKRMetric : MKREntityWithId

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *unitType;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber<RLMBool> *availableForIndividualTournaments;
@property (nonatomic, copy) NSNumber<RLMBool> *availableForTeamTournaments;
@property (nonatomic, copy) NSNumber<RLMBool> *availableForDuel;

+ (RKObjectMapping *)mapping;

@end