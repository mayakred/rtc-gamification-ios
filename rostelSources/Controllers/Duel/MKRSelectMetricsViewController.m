//
//  MKRSelectMetricsViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRSelectMetricsViewController.h"
#import "UIColor+MKRColor.h"
#import "UIViewController+Errors.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MKRMetric.h"
#import "MKRMetricsListPresenter.h"
#import "MKRMetric.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRSelectMetricsViewController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, MKRMetricsListDataDelegate>

@end

static NSString *const kMKRMetricCellIdentifier = @"metricCell";

@implementation MKRSelectMetricsViewController {
    MKRMetricsListPresenter *presenter;
    BOOL isLoadingMetrics;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    isLoadingMetrics = NO;
    [self.tableView setTableFooterView:[UIView new]];
    presenter = [[MKRMetricsListPresenter alloc] init];
    [presenter setDelegate:self];
    [presenter updateMetrics];
    
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
    return [presenter metricsCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMKRMetricCellIdentifier forIndexPath:indexPath];
    
    MKRMetric *metric = [presenter metricWithIndex:indexPath.row];
    [cell.textLabel setText:metric.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRMetric *metric = [presenter metricWithIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate didSelectMetric:metric];
    }
    [self.navigationController popViewControllerAnimated:YES];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
