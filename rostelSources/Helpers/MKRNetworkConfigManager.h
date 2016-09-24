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
#define API_DUELS_LIST                   @"users/me/duels"
#define API_ACCEPT_DUEL                  @"users/me/duels/:duelId/accept"
#define API_ACCEPT_DUEL_PATTERN          @"users/me/duels/%@/accept"
#define API_DECLINE_DUEL                 @"users/me/duels/:duelId/decline"
#define API_DECLINE_DUEL_PATTERN         @"users/me/duels/%@/decline"
#define API_TOURNAMENTS_LIST             @"users/:tourId/tournaments/active"
#define API_TOURNAMENTS_LIST_PATTERN     @"users/%@/tournaments/active"


@interface MKRNetworkConfigManager : NSObject

+ (void)setUpConfigs;

+ (void)setAuthHeaderWithToken:(NSString *)authToken;

+ (void)clearAuthHeaderToken;

+ (NSIndexSet *)defaultDescriptorsStatusCodes;

@end
