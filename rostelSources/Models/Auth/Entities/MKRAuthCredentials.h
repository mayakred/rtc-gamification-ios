//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface MKRAuthCredentials : RLMObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber<RLMInt> *userId;
@property (nonatomic, copy) NSNumber<RLMBool> *isFirstAuth; //bool

+ (RKObjectMapping *)mapping;

@end