//
//  ShareRemarkView.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/4.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UGRemarkView.h"
NS_ASSUME_NONNULL_BEGIN
@interface RemarkViewValue : NSObject
@property(assign, nonatomic) CGFloat pricein;
@property(assign, nonatomic) CGFloat priceout;
@property(assign, nonatomic) NSTimeInterval handletime;
@property(strong, nonatomic) NSString* remark;
@end
@interface ShareRemarkView : UIView

@property(strong, nonatomic) UILabel *titleLab; // 标题

@property(strong, nonatomic) UGRemarkView *priceinTF; // 建议买入价

@property(strong, nonatomic) UGRemarkView *priceoutTF; // 预估卖出价

@property(strong, nonatomic) UGRemarkView *timeTF; // 预估买入时间

@property(strong, nonatomic) UGRemarkView *remarkTF; // 测评意见

@property(strong, nonatomic) UIButton *commitBtn; // 确认按钮

@property(strong, readonly) RemarkViewValue *value;

-(void)reload:(RemarkViewValue*)info;
@end

NS_ASSUME_NONNULL_END
