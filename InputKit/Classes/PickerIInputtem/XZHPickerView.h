//
//  XZHPickerView.h
//  InputKit
//
//  Created by sfpay on 15/3/7.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PickerViewType) {
    PickerViewTypeOneClolumn    = 1, //一列的
    PickerViewTypeTwoClolumn    = 2, //二列的
    PickerViewTypeThreeClolumn    = 3, //三列的
    PickerViewTypeFourClolumn    = 4, //四列的
};


@class XZHPickerView;
@protocol XZHPickerViewDelegate <NSObject>
@optional
-(void)toobarDonBtnHaveClick:(XZHPickerView *)pickView resultString:(NSString *)resultString;
@end

@interface XZHPickerView : UIView

@property(nonatomic,weak) id<XZHPickerViewDelegate> delegate;


/**
 *  通过plistName添加一个pickView
 *
 *  @param plistName          plist文件的名字
 
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler;
/**
 *  通过plistName添加一个pickView
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param isHaveNavControler是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color;
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color;
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color;

@end
