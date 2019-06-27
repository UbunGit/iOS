//
//  TZPhotoPickerController.h
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TZAlbumModel;
@interface TZPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) UIView* bottomToolBar;
@property (nonatomic, strong) TZAlbumModel *model;

//全选
-(void)allSelect:(BOOL)isselctAll;

//确定
- (void)doneButtonClick;

@end


@interface TZCollectionView : UICollectionView

@end
