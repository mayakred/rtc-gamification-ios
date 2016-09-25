//
//  MKRDuelSelectuserViewController.h
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKRUser;

@protocol MKRDDuelSelectUserDelegate <NSObject>
@required
- (void)didSelectUser:(MKRUser *)user;
@end

@interface MKRDuelSelectuserViewController : UITableViewController

@property (nonatomic, weak) id <MKRDDuelSelectUserDelegate> delegate;

@end
