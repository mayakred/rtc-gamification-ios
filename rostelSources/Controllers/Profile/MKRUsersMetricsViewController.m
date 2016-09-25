//
//  MKRUsersMetricsViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRUsersMetricsViewController.h"
#import "MKRUsersMetricsPresenter.h"
#import "UIColor+MKRColor.h"
#import "UIViewController+Errors.h"
#import "MKRUserMetricTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRUsersMetricsViewController () <MKRUsersMetricsDataDelegate>

@end

static NSString *const kMKRMetricCellIdentifier = @"metricCell";

@implementation MKRUsersMetricsViewController {
    MKRUsersMetricsPresenter *presenter;
    BOOL isLoadingMetrics;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    isLoadingMetrics = NO;
    [self.tableView setTableFooterView:[UIView new]];
    presenter = [[MKRUsersMetricsPresenter alloc] initWitIsPerviySubview:self.perviySubview andMetricCode:self.metricCode];
    [presenter setDelegate:self];
    [presenter updateUsersMetrics];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"COUNT : %d", [presenter usersMetricsCount]);
    return [presenter usersMetricsCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRUserMetricTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMKRMetricCellIdentifier forIndexPath:indexPath];

    MKRUserMetricValue *metricValue = [presenter userMetricWithIndex:indexPath.row];
    [cell setData:metricValue];
    return cell;
}

#pragma mark - DZNEmptyDataSet delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = isLoadingMetrics ? @"Подождите" : @"Метрики отсутствуют";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
            NSForegroundColorAttributeName: [UIColor darkGrayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =  isLoadingMetrics ? @"Загружаем метрики" : @"Никто не юзает эту прогу";

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
            NSForegroundColorAttributeName: [UIColor lightGrayColor],
            NSParagraphStyleAttributeName: paragraph};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor mkr_emptyDataSetColor];
}

#pragma mark - MetricsPresenter Delegate

- (void)metricsListDidUpdateSuccess {
    isLoadingMetrics = NO;
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
}

- (void)metricsListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    isLoadingMetrics = NO;
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)metricsListWillUpdate {
    isLoadingMetrics = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}

@end
