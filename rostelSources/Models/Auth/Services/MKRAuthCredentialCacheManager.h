//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"

@class MKRAuthCredentials;

@interface MKRAuthCredentialCacheManager : MKRBaseCacheManager

- (BOOL)isAuthed;
- (BOOL)isFirstAuth;
- (NSString *)authToken;
- (NSNumber *)userId;
- (void)setTokenIsInvalid;

- (void)loadCredentials;

- (void)saveNewAuthCredentials:(MKRAuthCredentials *)newAuthCredentials;

@end