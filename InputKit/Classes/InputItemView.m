//
//  InputItemView.m
//  InputKit
//
//  Created by xiongzenghui on 15/3/5.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import "InputItemView.h"
#import "InputItem.h"
#import "NSString+Additions.h"
#import "XZHPickerView.h"

NSInteger NormalFontSize = 16.0f;
NSString *NormalFontName = @"Helvetica-Bold";
NSInteger PerItemHeight = 55;
NSInteger PerItemPadding = 10;
static NSInteger PlaceholderFontSize = 13.0f;
static NSString *PlaceholderFontName = @"Helvetica-Bold";
static UIColor *PlaceholderFontColor = nil;
static UIColor *NormalFontColor = nil;
static NSInteger InItemPadding = 10;
static NSString *titleFontName = @"Helvetica-Bold";
static NSInteger textFiledHeight = 45;

@interface InputItemView () <XZHPickerViewDelegate>
@property (strong, nonatomic) XZHPickerView *pickerView;
@property (copy, nonatomic) void (^onPickedResult)(NSString *resultString);
@end

@implementation InputItemView

+ (instancetype)instanceWithInputItem:(InputItem *)item {
    InputItemView *itemView = [[InputItemView alloc] init];
    [itemView initSubviewsWithType:item];
    PlaceholderFontColor = [UIColor lightGrayColor];
    NormalFontColor = [UIColor blackColor];
    return itemView;
}

- (void)initSubviewsWithType:(InputItem *) item {
    self.item = item;
    switch ([item inputType]) {
        case InputItemTypeLabel:
            [self initSubviewsWithInputItemTypeLabel];
            break;
        
        case InputItemTypeTextfiled:
            [self initSubviewsWithInputItemTypeTextfiled];
            break;
            
        case InputItemTypeDatePickerView:
            [self initSubviewsWithInputItemTypeDatePickerView];
            break;
            
        default:
            break;
    }
}

- (void)dealloc {
    self.item = nil;
    self.titleLabel = nil;
    self.nameLabel = nil;
    self.contentLabel = nil;
    self.subContentLabel = nil;
    self.textfiled = nil;
}

- (void)createSubviews {
    self.layer.borderWidth = 1;
    
    self.titleLabel = [[UILabel alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.textLabel = [[UILabel alloc] init];
    self.contentLabel = [[UILabel alloc] init];
    self.subContentLabel = [[UILabel alloc] init];
    self.textfiled = [[UITextField alloc] init];
    
    [self.titleLabel setAccessibilityIdentifier:@"titleLabel"];
    [self.nameLabel setAccessibilityIdentifier:@"nameLabel"];
//    [self.textLabel setAccessibilityIdentifier:@"textLabel"];
    [self.contentLabel setAccessibilityIdentifier:@"contentLabel"];
    [self.subContentLabel setAccessibilityIdentifier:@"subContentLabel"];
    [self.textfiled setAccessibilityIdentifier:@"textfiled"];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.numberOfLines = 0;
    [self.nameLabel sizeToFit];
    self.nameLabel.numberOfLines = 1;
    [self.contentLabel sizeToFit];
    self.contentLabel.numberOfLines = 1;
    [self.titleLabel sizeToFit];
    self.titleLabel.numberOfLines = 1;
    [self.subContentLabel sizeToFit];
    self.subContentLabel.numberOfLines = 1;
    [self.textfiled sizeToFit];
    self.textfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.textLabel];
    [self addSubview:self.subContentLabel];
    [self addSubview:self.textfiled];
}

- (void)initSubviewsWithInputItemTypeLabel {
    [self createSubviews];
    
    self.textfiled.keyboardType = UIKeyboardTypePhonePad;
    
    NSInteger SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    __weak __typeof(self) weakSelf = self;
    
    //1. titile
//    [self.titleLabel setText:[item itemTitie]];
//    [self.titleLabel sizeToFit];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        __weak __typeof(weakSelf) strongSelf = weakSelf;
//        make.left.mas_equalTo(strongSelf.mas_left).offset(5);
//        make.width.mas_equalTo(strongSelf.titleLabel.frame.size.width);
//        make.height.mas_equalTo(strongSelf.titleLabel.frame.size.height);
//        make.top.mas_equalTo(strongSelf.mas_top);
//    }];
    
    [self.nameLabel setText:[self.item itemName]];
    [self.contentLabel setText:[self.item itemContent]];
    [self.subContentLabel setText:[self.item itemSubContent]];
    
    CGSize size = [[self.nameLabel text] xzh_sizefont:[self getNormalFont] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.mas_left).offset(10);
        make.width.mas_equalTo((size.width+10));
        make.height.mas_equalTo(size.height);
        make.centerY.mas_equalTo(strongSelf);
    }];
    
    size = [[self.contentLabel text] xzh_sizefont:[self getNormalFont] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.nameLabel.mas_right).offset(10);
        make.width.mas_equalTo((size.width+10));
        make.height.mas_equalTo(size.height);
        make.centerY.mas_equalTo(strongSelf);
    }];
    
    size = [[self.subContentLabel text] xzh_sizefont:[self getNormalFont] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    [self.subContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.contentLabel.mas_right).offset(10);
        make.width.mas_equalTo((size.width+10));
        make.height.mas_equalTo(size.height);
        make.centerY.mas_equalTo(strongSelf);
    }];
}

- (void)initSubviewsWithInputItemTypeTextfiled {
    [self createSubviews];
    
    //数字键盘
    self.textfiled.keyboardType = UIKeyboardTypePhonePad;
    
    NSInteger SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    __weak __typeof(self) weakSelf = self;
    
    [self.nameLabel setText:[self.item itemName]];
    [self.textfiled setPlaceholder:[self.item itemPlaceHolder]];
    
    CGSize size = [[self.nameLabel text] xzh_sizefont:[self getNormalFont] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.mas_left).offset(10);
        make.width.mas_equalTo((size.width+10));
        make.height.mas_equalTo(size.height);
        make.centerY.mas_equalTo(strongSelf);
    }];

    [self.textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.nameLabel.mas_right).offset(10);
        make.right.mas_equalTo(strongSelf.mas_right);
        make.height.mas_equalTo(textFiledHeight);
        make.centerY.mas_equalTo(strongSelf);
        
    }];
}

- (void)initSubviewsWithInputItemTypeDatePickerView {
    [self createSubviews];
    
    NSInteger SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    __weak __typeof(self) weakSelf = self;
    
    [self.nameLabel setText:[self.item itemName]];
    [self.textfiled setPlaceholder:[self.item itemPlaceHolder]];
    
    CGSize size = [[self.nameLabel text] xzh_sizefont:[self getNormalFont] maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.mas_left).offset(10);
        make.width.mas_equalTo((size.width+10));
        make.height.mas_equalTo(size.height);
        make.centerY.mas_equalTo(strongSelf);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak __typeof(weakSelf) strongSelf = weakSelf;
        make.left.mas_equalTo(strongSelf.nameLabel.mas_right).offset(10);
        make.right.mas_equalTo(strongSelf.mas_right);
        make.height.mas_equalTo(textFiledHeight);
        make.centerY.mas_equalTo(strongSelf);
        
    }];
    
    self.textLabel.text = @"X月/X日";
    
    self.textLabel.userInteractionEnabled = YES;
    self.textLabel.accessibilityIdentifier = @"datePicker";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLabelClick:)];
    [self.textLabel addGestureRecognizer:tap];
}

- (void)validate {
  
    
    if ([self.item inputType] == InputItemTypeTextfiled) {
        //校验textFiled
        if ([self.textfiled.text isEqualToString:@""] || \
            (self.textfiled.text.length < 6))
        {
            self.isValid = NO;
        }else {
            self.isValid = YES;
        }
    } else if ([self.item inputType] == InputItemTypeDatePickerView) {
        //校验Date PickerView的值
        if ([self.textLabel.text isEqualToString:@""] || \
            (self.textLabel.text.length < 6)) {
            self.isValid = NO;
        }else {
            self.isValid = YES;
        }

    }
}

- (void)textLabelClick:(UITapGestureRecognizer *) gesture{
    if ([gesture.view.accessibilityIdentifier isEqualToString:@"datePicker"]) {
        
        UILabel *textLabel = (UILabel *)gesture.view;
        __weak __typeof(textLabel) weakLabel = textLabel;
        self.onPickedResult = ^(NSString *resultString) {
            __weak __typeof(weakLabel) strongLabel = weakLabel;
            strongLabel.text = resultString;
        };
        
        [self postPickerViewBeginNotification];
        [self showDatePickerViewWithType:InputItemTypeDatePickerView];
    }
}

- (void)showDatePickerViewWithType:(InputItemType) type {
    [_pickerView remove];
    
    
    if (type == InputItemTypeDatePickerView) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:9000000];
        _pickerView = [[XZHPickerView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    }
    
    _pickerView.delegate = self;
    [_pickerView show];
}

#pragma mark - pickerview delegate
-(void)toobarDonBtnHaveClick:(XZHPickerView *)pickView resultString:(NSString *)resultString{
    if (self.onPickedResult) {
        self.onPickedResult(resultString);
    }
    
    [self postPickerViewEndNotification];
}

- (void)postPickerViewBeginNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    __weak __typeof(center) weakcenter = center;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(weakcenter) strongcenter = weakcenter;
        
        [strongcenter postNotificationName:DatePickerViewBeginEditNotification object:self];
    });
}

- (void)postPickerViewEditingNotification {
    
}

- (void)postPickerViewEndNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    __weak __typeof(center) weakcenter = center;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(weakcenter) strongcenter = weakcenter;
        
        [strongcenter postNotificationName:DatePickerViewEndEditNotification object:self];
    });
}

- (UIFont *)getNormalFont {
    return [UIFont fontWithName:NormalFontName size:NormalFontSize];
}

- (UIFont *)getPlaceHolderFont {
    return [UIFont fontWithName:PlaceholderFontName size:PlaceholderFontSize];
}

@end
