//
//  Defind.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//

#ifndef Defind_h
#define Defind_h

#import "Font.h"
#import "Color.h"


#define UGIMAGE(str) [UIImage imageNamed:str]
#define UGURL(str) [NSURL URLWithString:str]


#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

//根据屏幕宽度计算对应尺寸
#define KAutoAcale(x) x*(KWidth/375)

//间距
#define KPAND_DEF 15 //默认间距
#define KPAND_MID 10 //小间距
#define KPAND_MIN 5 //小间距

//弱引用
#define UG_WEAKSELF __weak typeof(self) weakSelf = self;

#endif /* Defind_h */
