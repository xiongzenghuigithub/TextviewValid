//
//  InputItemView.h
//  InputKit
//
//  Created by xiongzenghui on 15/3/5.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  InputItem;

FOUNDATION_EXPORT NSInteger PerItemHeight;
FOUNDATION_EXPORT NSInteger PerItemPadding;
FOUNDATION_EXPORT NSInteger NormalFontSize;
FOUNDATION_EXPORT NSString *NormalFontName;

@interface InputItemView : UIView
@property (assign, nonatomic) BOOL isValid;
@property (nonatomic, strong) InputItem *item;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *subContentLabel;
@property (strong, nonatomic) UITextField *textfiled;


+ (instancetype)instanceWithInputItem:(InputItem *) item;
- (void)validate;   //校验内容是否合法

@end
