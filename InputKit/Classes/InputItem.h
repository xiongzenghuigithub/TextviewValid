//
//  InputItem.h
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InputItemView;
@class  InputItem;

FOUNDATION_EXPORT NSString *const DatePickerViewBeginEditNotification;
FOUNDATION_EXPORT NSString *const DatePickerViewDidEditingNotification;
FOUNDATION_EXPORT NSString *const DatePickerViewEndEditNotification;


typedef NS_ENUM(NSInteger, InputItemType) {
    InputItemTypeLabel                   = 1,
    InputItemTypeTextfiled                  ,
    InputItemTypeDatePickerView             ,
    InputItemTypeCityPickerView             ,
    InputItemTypeDynamicArrayPickerView     ,
};

//每一个Item的接收的回调Block
typedef void (^ItemBeginEditCallback)(UIView *inputView);         //开始编辑
typedef void (^ItemEditingCallback)(UIView *inputView);           //已经输入内容
typedef void (^ItemEndEditCallback)(UIView *inputView);           //编辑完毕


@interface InputItem : NSObject

@property (assign, nonatomic) BOOL isNeedValidate;  //是否需要校验输入的参数值
@property (assign, nonatomic) InputItemType inputType;
@property (copy, nonatomic) NSString *itemTitie;
@property (copy, nonatomic) NSString *itemName;
@property (copy, nonatomic) NSString *itemPlaceHolder;
@property (copy, nonatomic) NSString *itemContent;
@property (copy, nonatomic) NSString *itemSubContent;

@property (copy, nonatomic) ItemBeginEditCallback  beginEditCallback;
@property (copy, nonatomic) ItemEditingCallback  editingCallback;
@property (copy, nonatomic) ItemEndEditCallback  endEditCallback;

- (void)addItemBeginCallback:(ItemBeginEditCallback) begin
         ItemEditingCallback:(ItemEditingCallback) editing
         ItemEndEditCallback:(ItemEndEditCallback) end;


@end
