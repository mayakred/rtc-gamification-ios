//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_AUTH_REQUEST                 @"auth/request"
#define API_AUTH_CONFIRM                 @"auth/confirm"
#define API_AUTH_LOGOUT                  @"logout"
#define API_CURRENT_USER                 @"users/me"
#define API_GET_USER                     @"users/:id/"
#define API_GET_USER_PATTERN             @"users/%@/"
#define API_REGISTER_PLAYER_ID           @"users/me/players"
#define API_USERS_LIST                   @"users"


@interface MKRNetworkConfigManager : NSObject

+ (void)setUpConfigs;

+ (void)setAuthHeaderWithToken:(NSString *)authToken;

+ (void)clearAuthHeaderToken;

+ (NSIndexSet *)defaultDescriptorsStatusCodes;

@end
