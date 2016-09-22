//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRTournament.h"
#import "MKRTeam.h"


@interface MKRFullTournament : MKRTournament

@property (nonatomic, copy) NSNumber<RLMInt> *startAt;
@property (nonatomic, copy) NSNumber<RLMInt> *endAt;
@property (nonatomic) RLMArray<MKRTeam> *teams;

@end