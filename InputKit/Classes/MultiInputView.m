//
//  MultiInputView.m
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import "MultiInputView.h"
#import "InputItemView.h"
#import "UIColor+expanded.h"
#import "NSString+Additions.h"


static NSInteger ItemPadding = 10;

@interface MultiInputView ()
@property (strong, nonatomic, readwrite) NSMutableArray *itemsArray;
@property (copy, nonatomic) GetAllItemsValueCallback getAllItemsCallback;
@property (copy, nonatomic) NotFillValueFirstItemCallback notFillFirstItemCallback;

@end

@implementation MultiInputView


#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigs];
    }
    return self;
}

- (void)dealloc {
    [self destroyConfigs];
}

- (void)initConfigs {
    [self initVariables];
    [self addNotifications];
}

- (void)destroyConfigs {
    [self destroyVariables];
    [self removeNotifications];
    [self destroySubviews];
}

- (void)initVariables {
    self.itemsArray = [NSMutableArray array];
}

- (void)destroyVariables {
    self.itemsArray = nil;
}

- (void)destroySubviews {
    for (InputItemView *itemView in self.subviews) {
        [itemView removeFromSuperview];
    }
}

- (void)addNotifications {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(didReceivedNotifications:)
                   name:UITextFieldTextDidBeginEditingNotification object:nil];
    [center addObserver:self selector:@selector(didReceivedNotifications:)
                   name:UITextFieldTextDidEndEditingNotification object:nil];
    [center addObserver:self selector:@selector(didReceivedNotifications:)
                   name:UITextFieldTextDidChangeNotification object:nil];
    
    [center addObserver:self selector:@selector(didReceivedNotifications:)
                   name:DatePickerViewBeginEditNotification object:nil];
    [center addObserver:self selector:@selector(didReceivedNotifications:)
                   name:DatePickerViewDidEditingNotification object:nil];
    [center addObserver:self selector:@selector(didReceivedNotifications:)
                   name:DatePickerViewEndEditNotification object:nil];
}

- (void)removeNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [center removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [center removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    [center removeObserver:self name:DatePickerViewBeginEditNotification object:nil];
    [center removeObserver:self name:DatePickerViewDidEditingNotification object:nil];
    [center removeObserver:self name:DatePickerViewEndEditNotification object:nil];
}

- (void)didReceivedNotifications:(NSNotification *) sender {
    
    NSString *notificatioName = sender.name;
    UIView *eventTriggerView = sender.object;
    InputItem *finedItem = [self findInputItemWithSubviewInItemView:eventTriggerView];
    
    if (notificatioName == UITextFieldTextDidBeginEditingNotification || \
        notificatioName == DatePickerViewBeginEditNotification)
    {
        if (finedItem.beginEditCallback) {
            finedItem.beginEditCallback(eventTriggerView);
        }
        
        //当弹起PickerView之前，取消所有输入项的focus状态
        if (notificatioName == DatePickerViewBeginEditNotification) {
            [self cancelAllFucos];
        }
    }
    
    if (notificatioName == UITextFieldTextDidChangeNotification || \
        notificatioName == DatePickerViewDidEditingNotification)
    {
        if (finedItem.editingCallback) {
            finedItem.editingCallback(eventTriggerView);
        }
        
        //只要有一个输入项处于编辑，就马上校验所有的输入项
        if ([[eventTriggerView superview] isKindOfClass:[InputItemView class]]) {
            [self validateAllInputItems];
        }
    }
    
    if (notificatioName == UITextFieldTextDidEndEditingNotification || \
        notificatioName == DatePickerViewEndEditNotification)
    {
        [self validateAllInputItems];
        
        if (finedItem.endEditCallback) {
            finedItem.endEditCallback(eventTriggerView);
        }
    }
}

#pragma maek - add items
- (void)addInputItem:(InputItem *)item {
    [self.itemsArray addObject:item];
}

#pragma mark - init sub items
- (void)initSubInputItems {
    
    __weak __typeof(self) weakSelf = self;
    self.accessibilityIdentifier = @"MultiInputView";
    CGFloat SCREEN_WIDTH = [[UIScreen mainScreen] bounds].size.width;
    
    //控件的总高度
    NSInteger height = [[self itemsArray] count] * PerItemHeight + [[self itemsArray] count] * PerItemPadding;
    for (InputItem *item in [self itemsArray]) {
        NSString *title = [item itemTitie];
        CGSize titleLabelSize = [title xzh_sizefont:[UIFont fontWithName:NormalFontName size:NormalFontSize] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        height += titleLabelSize.height;
    }
    
    //布局MultiinputView
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.superview.mas_left);
        make.right.mas_equalTo(strongSelf.superview.mas_right);
        make.top.mas_equalTo(strongSelf.superview.mas_top).offset(40);
        make.height.mas_equalTo(height);
    }];
//    self.backgroundColor = [UIColor redColor];
    
    //布局其他ItemView
    UIView *lastView = nil;
    for ( int i = 0; i < [[self itemsArray] count]; i++) {
        InputItem *item = [self.itemsArray objectAtIndex:i];
        InputItemView *itemView = [InputItemView instanceWithInputItem:item];
        itemView.tag = i+1;
//        itemView.backgroundColor = [UIColor blueColor];
        itemView.accessibilityIdentifier = [NSString stringWithFormat:@"我是Tag=%d的ItemView\n", i+1];
        [self addSubview:itemView];
        
        if (![[item itemTitie] isEqualToString:@""] || \
            ![item itemTitie])
        {
            // titileLabel的高度
            CGSize titleLabelSize = [[item itemTitie] xzh_sizefont:[UIFont fontWithName:NormalFontName size:NormalFontSize] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
            
            //加上每一个Item自身的固定高度
            NSInteger height = titleLabelSize.height + PerItemHeight;
            
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                make.left.mas_equalTo(strongSelf.mas_left);
                make.right.mas_equalTo(strongSelf.mas_right);
                make.top.mas_equalTo(lastView?lastView.mas_bottom:self.mas_top).offset(ItemPadding);
                make.height.mas_equalTo(height);
            }];
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                make.left.mas_equalTo(strongSelf.mas_left);
                make.right.mas_equalTo(strongSelf.mas_right);
                make.top.mas_equalTo(lastView?lastView.mas_bottom:self.mas_top).offset(ItemPadding);
                make.height.mas_equalTo(PerItemHeight);
            }];
        }
        
        lastView = itemView;
    }
    
}

#pragma mark - add callbacks
//保存Blocks，后面调用
- (void)addGetAllItemsValueCallback:(GetAllItemsValueCallback)getValues
      NotFillValueFirstItemCallback:(NotFillValueFirstItemCallback)notFillfirstItem
{
    self.getAllItemsCallback = nil;
    self.notFillFirstItemCallback = nil;
    
    self.getAllItemsCallback = getValues;
    self.notFillFirstItemCallback = notFillfirstItem;
}

- (InputItem *)findInputItemWithSubviewInItemView:(UIView *) subView {
    //通知包含的view.superView.item对象
    InputItem *item = nil;
    if ([[subView superview] isKindOfClass:[InputItemView class]]) {
        InputItemView *itemView = (InputItemView *)subView.superview;
        item = itemView.item;
    }
    return item;
}

- (InputItemView *)findItemViewByItem:(InputItem *)item {
    InputItemView *findedItemView = nil;
    for (InputItemView *itemView in self.subviews) {
        if (itemView.item == item) {
            findedItemView = itemView;
        }
    }
    return findedItemView;
}

#pragma mark - 同一时刻，校验所有的输入项
- (void)validateAllInputItems {
    
    InputItemView *firstNotFillItemView = nil;
    BOOL isValid = YES;
    for (InputItem *item in [self itemsArray]) {
        
        //当前输入项是否需要校验
        if ([item isNeedValidate]) {
            
            //输入项校验
            InputItemView *itemView = [self findItemViewByItem:item];
            [itemView validate];
            
            //清除border
            itemView.layer.borderWidth = 1;
            itemView.layer.borderColor = [UIColor blackColor].CGColor;
            
            //合并多个输入项的校验结果
            isValid = isValid && itemView.isValid;
            
            //只要当前第一个输入项校验失败，即所有校验失败
            if (![itemView isValid]) {
                firstNotFillItemView = itemView;    //记录第一个校验失败的项
                break;
            }

        }
    }
    
    if (isValid) {
        if (self.getAllItemsCallback) {
            self.getAllItemsCallback([self getAllItemsValues]);
        }
    }else {
        
        //1. border显示红色
        firstNotFillItemView.layer.borderWidth = 2;
        firstNotFillItemView.layer.borderColor = [UIColor redColor].CGColor;
        
        //2. 回传
        if (self.notFillFirstItemCallback) {
            self.notFillFirstItemCallback(firstNotFillItemView);
        }
    }
}

- (void)cancelAllFucos {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[InputItemView class]]) {
            for (UIView *view in subView.subviews) {
                [view resignFirstResponder];
            }
        }
    }
}

- (NSArray *)getAllItemsValues {
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[InputItemView class]]) {
            InputItemView *itemView = (InputItemView *)subView;
            if ([[itemView item] isNeedValidate]) {//当前输入项需要校验
                if ([itemView.item inputType] == InputItemTypeTextfiled) {
                    [array addObject:itemView.textfiled.text];
                }else if ([itemView.item inputType] == InputItemTypeDatePickerView) {
                    [array addObject:itemView.textLabel.text];
                }
            }
        }
    }
    return array;
}

@end
