//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRImage.h"
#import "MKRDepartment.h"
#import "MKRMetric.h"

@class RKObjectMapping;

@interface MKRUserMetricValue : MKREntityWithId

@property (nonatomic, copy) NSNumber<RLMDouble> *metricValue;
@property (nonatomic, copy) NSNumber<RLMBool> *isPerviySubview;
@property (nonatomic, copy) NSString *userFullName;
@property (nonatomic ) MKRImage *userAvatar;
@property (nonatomic ) MKRDepartment *userDepartment;
@property (nonatomic ) MKRMetric *metric;

+ (RKObjectMapping *)mapping;

@end