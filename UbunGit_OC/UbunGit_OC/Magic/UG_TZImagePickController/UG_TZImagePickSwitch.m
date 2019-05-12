//
//  UG_TZImagePickSwitch.m
//  UbunGit_OC
//
//  Created by admin on 2019/5/12.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UG_TZImagePickSwitch.h"
#import "TZImagePickerController.h"
@interface UG_TZImagePickSwitch ()

@property(strong, nonnull)NSArray *tableViewarr;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation UG_TZImagePickSwitch

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaderData];
    [_tableview reloadData];
    
    
}
-(void)loaderData{
    _tableViewarr = @[@"选择相册",@"选择视频"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _tableViewarr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
 
    cell.textLabel.text = [_tableViewarr objectAtIndex:indexPath.row];
 
    return cell;
}


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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    /**
     * NSPhotoLibraryUsageDescription
     */
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9999 delegate:nil];
    imagePickerVc.hideWhenCanNotSelect = YES;
    imagePickerVc.preferredLanguage = @"zh-Hans";
    imagePickerVc.onlyReturnAsset = YES;
    [imagePickerVc setPhotoPickerBottomToolBarConfigBlock:^UIView *(TZPhotoPickerController *photoPickerController) {
        UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 44)];
        aview.backgroundColor = [UIColor yellowColor];
        UIButton *abutton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 24)];
        [aview addSubview:abutton];
        [abutton setTitle:@"全选" forState:UIControlStateSelected];
        [abutton setTitle:@"全不选" forState:UIControlStateNormal];
        [abutton ug_addEvents:UIControlEventTouchUpInside andBlock:^(UIButton* sender) {
            
            if(sender.selected){
                [photoPickerController allSelect:YES];
                abutton.selected = NO;
            }else{
                [photoPickerController allSelect:NO];
                abutton.selected = YES;
            }
            
        }];
        
        UIButton *dounbtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 10, 44, 24)];
        dounbtn.backgroundColor = [UIColor blueColor];
        [dounbtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(UIButton* sender) {
            [photoPickerController doneButtonClick];
        }];
         [aview addSubview:dounbtn];
        return aview;
    }];
//    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
//
//        bottomToolBar.backgroundColor = [UIColor yellowColor];
//
//    }];
    if ([[_tableViewarr objectAtIndex:indexPath.row]isEqualToString:@"选择相册"]) {
        imagePickerVc.allowPickingVideo = NO;
      
        [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
            ;
        }];
    }else if ([[_tableViewarr objectAtIndex:indexPath.row]isEqualToString:@"选择视频"]) {
        [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
           
        }];
    }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    imagePickerVc.navigationController.navigationItem.rightBarButtonItem= nil;
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
