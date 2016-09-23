//
// Created by Anton Zlotnikov on 15.06.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Realm/Realm.h>
#import "MKRSecurityManager.h"


@implementation MKRSecurityManager {

}

+ (RLMRealm *)getRealm {
    return [RLMRealm defaultRealm];
    @autoreleasepool {
        RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
        configuration.encryptionKey = [MKRSecurityManager getRealmKey];
        NSError *error = nil;
        RLMRealm *realm = [RLMRealm realmWithConfiguration:configuration
                                                     error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        return realm;
    }
}

+ (NSData *)getRealmKey {
    // Identifier for our keychain entry - should be unique for your application
    static const uint8_t kKeychainIdentifier[] = "com.mayak.rostelRealmKey";
    NSData *tag = [[NSData alloc] initWithBytesNoCopy:(void *)kKeychainIdentifier
                                               length:sizeof(kKeychainIdentifier)
                                         freeWhenDone:NO];

    // First check in the keychain for an existing key
    NSDictionary *query = @{(__bridge id)kSecClass: (__bridge id)kSecClassKey,
            (__bridge id)kSecAttrApplicationTag: tag,
            (__bridge id)kSecAttrKeySizeInBits: @512,
            (__bridge id)kSecReturnData: @YES};

    CFTypeRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataRef);
    if (status == errSecSuccess) {
        return (__bridge NSData *)dataRef;
    }

    // No pre-existing key from this application, so generate a new one
    uint8_t buffer[64];
    SecRandomCopyBytes(kSecRandomDefault, 64, buffer);
    NSData *keyData = [[NSData alloc] initWithBytes:buffer length:sizeof(buffer)];

    // Store the key in the keychain
    query = @{(__bridge id)kSecClass: (__bridge id)kSecClassKey,
            (__bridge id)kSecAttrApplicationTag: tag,
            (__bridge id)kSecAttrKeySizeInBits: @512,
            (__bridge id)kSecValueData: keyData};

    status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    NSAssert(status == errSecSuccess, @"Failed to insert new key in the keychain");

    return keyData;
}

@end