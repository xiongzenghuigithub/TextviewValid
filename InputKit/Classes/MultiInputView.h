//
//  MultiInputView.h
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputItemFactory.h"

/* 所有输入项的值 */
typedef void (^GetAllItemsValueCallback)(NSArray *itemValues);

/* 第一个验证错误的输入项 */
typedef void (^NotFillValueFirstItemCallback)(InputItemView *itemView);

@interface MultiInputView : UIView

@property (strong, nonatomic, readonly) NSMutableArray *itemsArray;


/**
 *  添加ItemView
 */
- (void)addInputItem:(InputItem *) item;

/**
 *  布局所有的ItemView
 */
- (void)initSubInputItems;

/**
 *  添加回调所有输入项的值
 */
- (void)addGetAllItemsValueCallback:(GetAllItemsValueCallback) getValues
      NotFillValueFirstItemCallback:(NotFillValueFirstItemCallback) notFillfirstItem;


/**
 *  取消所有焦点
 */
- (void)cancelAllFucos;
@end
