//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAuthCredentialCacheManager.h"
#import "MKRAuthCredentials.h"

@implementation MKRAuthCredentialCacheManager {
    MKRAuthCredentials *authCredential;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    [self loadCredentials];

    return self;
}

- (void)loadCredentials {
    authCredential = [[self RLMResultsToNSArray:[MKRAuthCredentials allObjects]] firstObject];
    if (authCredential) {
        NSLog(@"Loaded auth credentials from defaults with token: %@", authCredential.token);
    }
}

- (void)saveNewAuthCredentials:(MKRAuthCredentials *)newAuthCredentials {
    NSParameterAssert(newAuthCredentials);

    NSLog(@"Saving auth credentials to defaults with token: %@", newAuthCredentials.token);
    authCredential = newAuthCredentials;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[MKRAuthCredentials allObjects]];
    [realm addObject:newAuthCredentials];
    [realm commitWriteTransaction];

}

- (BOOL)isAuthed {
    return (authCredential != nil) && (authCredential.token != nil) && (![authCredential.token isEqualToString:@""]);
}

- (BOOL)isFirstAuth {
    if (![self isAuthed]) {
        return NO;
    }
    return [authCredential.isFirstAuth boolValue];
}


- (NSString *)authToken {
    if (![self isAuthed]) {
        return nil;
    }
    return authCredential.token;
}

- (void)resetAuthCredentials {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[MKRAuthCredentials allObjects]];
    [realm commitWriteTransaction];
    authCredential = nil;
}

- (NSNumber *)userId {
    if (![self isAuthed]) {
        return nil;
    }
    return (NSNumber *) authCredential.userId;
}

- (void)setTokenIsInvalid {
    NSLog(@"Set Token is invalid");
    [self resetAuthCredentials];
    //TODO post notification

}



@end
