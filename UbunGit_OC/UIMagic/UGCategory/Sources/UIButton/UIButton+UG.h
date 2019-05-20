//
//  UIButton+UG.h
//  LHCloud
//
//  Created by admin on 2019/5/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN



@interface UIButton (UG)



/**
 * button 图片赋值/图片名称必须规范
 *  imagestr_Normal
 *  imagestr_Highlighted
 *  imagestr_Disabled
 *  imagestr_Selected
 *  imagestr_Focused
 *  imagestr_Application
 *  imagestr_Reserved
 */
-(void)ug_setImage:(NSString *)imagestr;


@end

NS_ASSUME_NONNULL_END
