//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRDuel;

@protocol MKRDuelsListDataDelegate <NSObject>
@required
- (void)duelsListDidUpdateSuccess;
- (void)duelsListDidUpdateWithError:(MKRErrorContainer *)errorContainer;
- (void)duelsListWillUpdate;
@end

@interface MKRDuelsListPresenter : NSObject

@property (nonatomic, weak) id <MKRDuelsListDataDelegate> delegate;

- (void)loadDuelsIds;

- (void)updateDuels;

- (MKRDuel *)duelWithIndex:(NSUInteger)index;

- (NSUInteger)duelsCount;

- (void)serviceUpdatedDuelsListSuccessfully;

- (void)serviceUpdatedDuelsListWithError:(MKRErrorContainer *)errorContainer;

- (void)serviceWillUpdateDuelsList;
@end