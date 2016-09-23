//
// Created by Anton Zlotnikov on 15.06.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface MKRSecurityManager : NSObject
+ (RLMRealm *)getRealm;
@end