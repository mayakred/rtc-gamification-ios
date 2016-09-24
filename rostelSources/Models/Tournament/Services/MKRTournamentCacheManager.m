//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRTournamentCacheManager.h"
#import "MKRSecurityManager.h"
#import "MKRTournament.h"
#import "MKRDuel.h"


@implementation MKRTournamentCacheManager {

}

- (void)saveTournamentsList:(NSArray *)toursList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:toursList];
    [realm commitWriteTransaction];
}

- (MKRTournament *)tournamentWithType:(NSString *)tourType {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    NSArray *arr = [self RLMResultsToNSArray:[MKRTournament objectsInRealm:realm withPredicate:[NSPredicate predicateWithFormat:@"type == %@", tourType]];
    return [arr count] > 0 ? arr[0] : nil;
};


- (void)clearAllCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[MKRTournament allObjectsInRealm:realm]];
    [realm commitWriteTransaction];
}


@end