//
//  MKRProfileViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRProfileViewController.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"
#import "MKRProfileAchievementsCollectionViewController.h"
#import "MKRUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKRProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingTypeLabel;

@end

static NSString *const kMKRAchievementsSegueIdentitifer = @"achievementsSegue";

@implementation MKRProfileViewController {
    MKRProfileAchievementsCollectionViewController *achievementsController;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView setTableFooterView:[UIView new]];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;

    [self reloadUserInfo];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadUserInfo {
    MKRFullUser *user = [MKRAppDataProvider shared].userService.currentUser;
    NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:[user fullName]];
    [self.departmentLabel setText:user.department.name];
    [self.positionLabel setText:[NSString stringWithFormat:@"%@", user.topPosition]];
    NSString *ratingStr = [MKRUtils bytesToString:[user.rating integerValue]];
    [self.ratingLabel setText:[ratingStr componentsSeparatedByString:@" "][0]];
    [self.ratingTypeLabel setText:[ratingStr componentsSeparatedByString:@" "][1]];
    [achievementsController setAchievements:user.achievements];
    [achievementsController reloadData];
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([segue.identifier isEqualToString:kMKRAchievementsSegueIdentitifer]) {
       achievementsController = segue.destinationViewController;
   }
}


@end
