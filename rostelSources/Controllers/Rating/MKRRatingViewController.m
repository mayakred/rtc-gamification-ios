//
//  MKRRatingViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 23.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRRatingViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MKRUsersListPresenter.h"
#import "UIViewController+Errors.h"
#import "UIColor+MKRColor.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRRatingViewController () <UITableViewDataSource, UITableViewDelegate,
        DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, MKRUsersListDataDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *listTypeSegment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)listTypeSegmentChange:(id)sender;

@end


@implementation MKRRatingViewController {
    BOOL isLoadingUsers;
    UIRefreshControl *refreshControl;
    MKRUsersListPresenter *presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadingUsers = NO;
    [self.tableView setTableFooterView:[UIView new]];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [refreshControl addTarget:self action:@selector(refreshTriggered) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    presenter = [[MKRUsersListPresenter alloc] init];
    [presenter setDelegate:self];
//    [presenter updateUsers];
}

- (void)refreshTriggered {
    [refreshControl endRefreshing];
    [presenter updateUsers];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - DZNEmptyDataSet delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = isLoadingUsers ? @"Подождите" : @"Пользователи отсутствуют";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
            NSForegroundColorAttributeName: [UIColor darkGrayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =  isLoadingUsers ? @"Загружаем рейтинг" : @"Никто не юзает эту прогу";

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

#pragma mark - Presenter Delegate

- (void)usersListDidUpdateSuccess {
    isLoadingUsers = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
}

- (void)usersListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    isLoadingUsers = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)usersListWillUpdate {
    isLoadingUsers = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}

#pragma mark - User Actions

- (IBAction)listTypeSegmentChange:(id)sender {
}


@end
