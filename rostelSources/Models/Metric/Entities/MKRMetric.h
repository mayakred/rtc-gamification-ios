//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class RKObjectMapping;

@interface MKRMetric : RLMObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *unitType;
@property (nonatomic, copy) NSString *name;

+ (RKObjectMapping *)mapping;

@end