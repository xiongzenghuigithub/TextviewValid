//
//  InputItem.m
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import "InputItem.h"

NSString *const DatePickerViewBeginEditNotification = @"DatePickerViewBeginEditNotification";
NSString *const DatePickerViewDidEditingNotification = @"DatePickerViewDidEditingNotification";
NSString *const DatePickerViewEndEditNotification = @"DatePickerViewEndEditNotification";

@interface InputItem ()

@end


@implementation InputItem


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigs];
    }
    return self;
}

- (void)dealloc {
    [self destroyConfigs];
}

- (void)initConfigs {
    self.inputType = InputItemTypeTextfiled;    //默认时输入框
}

- (void)destroyConfigs {
    self.beginEditCallback = nil;
    self.editingCallback = nil;
    self.endEditCallback = nil;
}

- (void)clear {
    self.beginEditCallback = nil;
    self.editingCallback = nil;
    self.endEditCallback = nil;
}

- (void)addItemBeginCallback:(ItemBeginEditCallback)begin
         ItemEditingCallback:(ItemEditingCallback)editing
         ItemEndEditCallback:(ItemEndEditCallback)end
{
    [self clear];
    self.beginEditCallback = begin;
    self.editingCallback = editing;
    self.endEditCallback = end;
}

@end
