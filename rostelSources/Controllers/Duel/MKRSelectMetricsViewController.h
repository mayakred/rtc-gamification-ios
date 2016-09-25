//
//  MKRSelectMetricsViewController.h
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKRMetric;

@protocol MKRDDuelSelectmetricDelegate <NSObject>
@required
- (void)didSelectMetric:(MKRMetric *)metric;
@end

@interface MKRSelectMetricsViewController : UITableViewController

@property (nonatomic, weak) id <MKRDDuelSelectmetricDelegate> delegate;

@end
