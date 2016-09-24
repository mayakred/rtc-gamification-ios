//
//  MKRDuelsViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRDuelsViewController.h"
#import "MKRDuelsListPresenter.h"
#import "MKRDuelTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIColor+MKRColor.h"
#import "UIViewController+Errors.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRDuelsViewController () <MKRDuelsListDataDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

static NSString *const kMKRDuelCellIdentifier = @"duelCell";

@implementation MKRDuelsViewController {
    MKRDuelsListPresenter *presenter;
    BOOL isLoadingDuels;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadingDuels = NO;
    [self.tableView setTableFooterView:[UIView new]];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [refreshControl addTarget:self action:@selector(refreshTriggered) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    presenter = [[MKRDuelsListPresenter alloc] init];
    [presenter setDelegate:self];
    [presenter updateDuels];
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTriggered {
    [refreshControl endRefreshing];
    [presenter updateDuels];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [presenter duelsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRDuelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMKRDuelCellIdentifier forIndexPath:indexPath];
    MKRDuel *duel = [presenter duelWithIndex:indexPath.row];
    [cell setData:duel];
    return cell;
}

#pragma mark - DZNEmptyDataSet delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = isLoadingDuels ? @"Подождите" : @"Дуэлей нет";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
            NSForegroundColorAttributeName: [UIColor darkGrayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =  isLoadingDuels ? @"Загружаем дуэли" : @"Вызовите кого-нить на дуэль";

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

- (void)duelsListDidUpdateSuccess {
    isLoadingDuels = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
}

- (void)duelsListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    isLoadingDuels = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)duelsListWillUpdate {
    isLoadingDuels = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
