//
//  MKRCreateDuelViewController.h
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKRDuelCreatedDelegate <NSObject>
@required
- (void)duelCreated;
@end

@interface MKRCreateDuelViewController : UITableViewController

@property (nonatomic, weak) id <MKRDuelCreatedDelegate> delegate;

@end
