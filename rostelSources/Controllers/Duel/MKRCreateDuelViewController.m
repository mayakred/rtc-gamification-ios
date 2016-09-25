//
//  MKRCreateDuelViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRCreateDuelViewController.h"
#import "MKRDuelSelectuserViewController.h"
#import "MKRUser.h"
#import "MKRSelectMetricsViewController.h"
#import "MKRAppDataProvider.h"
#import "UIViewController+Errors.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRCreateDuelViewController () <MKRDDuelSelectUserDelegate, MKRDDuelSelectmetricDelegate>
@property (weak, nonatomic) IBOutlet UILabel *selectedUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedMetricLabel;
- (IBAction)pressDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end

static NSString *const kMKRSelectUserSegueIdentifier = @"selectUserSegue";
static NSString *const kMKRSelectMetricSegueIdentifier = @"selectMetricSegue";

@implementation MKRCreateDuelViewController {
    MKRUser *selectedUser;
    MKRMetric *selectedMetric;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;

    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];

    [self.timePicker setMinimumDate:nextDate];
    dayComponent.day = 31;
    NSDate *maxDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    [self.timePicker setMaximumDate:maxDate];

    selectedUser = nil;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSelectedUser {
    [self.selectedUserLabel setText:[selectedUser fullName]];
}

- (void)updateSelectedMetric {
    [self.selectedMetricLabel setText:selectedMetric.name];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kMKRSelectUserSegueIdentifier]) {
        [(MKRDuelSelectuserViewController *)segue.destinationViewController setDelegate:self];
    }
    if ([segue.identifier isEqualToString:kMKRSelectMetricSegueIdentifier]) {
        [(MKRSelectMetricsViewController *)segue.destinationViewController setDelegate:self];
    }
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - SelectUserDelegate

- (void)didSelectUser:(MKRUser *)user {
    selectedUser = user;
    [self updateSelectedUser];
}

#pragma mark - SelectMetricDelegate

- (void)didSelectMetric:(MKRMetric *)metric {
    selectedMetric = metric;
    [self updateSelectedMetric];
}

#pragma mark - UserActions

- (IBAction)pressDone:(id)sender {
    if (!selectedMetric || !selectedUser) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    NSNumber *endAt = @([self.timePicker.date timeIntervalSince1970]);
    [[MKRAppDataProvider shared].duelsService createDuelWithVictimId:selectedUser.itemId andMetricCode:selectedMetric.code
                                                            andEndAt:endAt success:^(MKRDuel *duel) {
                [MBProgressHUD hideHUDForView:self.tableView animated:YES];
                if (self.delegate) {
                    [self.delegate duelCreated];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(MKRErrorContainer *errorContainer) {
                [MBProgressHUD hideHUDForView:self.tableView animated:YES];
                [self showErrorForErrorContainer:errorContainer];
            }];
}
@end
