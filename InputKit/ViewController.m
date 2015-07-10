//
//  ViewController.m
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import "ViewController.h"
#import "MultiInputView.h"
#import "XZHPickerView.h"
#import "ZHTableViewController.h"

@interface ViewController ()
@property (strong, nonatomic)MultiInputView *multiView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAllFocus)];
    [self.view addGestureRecognizer:tap];
    
    //1.
    _multiView = [[MultiInputView alloc] initWithFrame:CGRectZero];
    
    //2.
    [_multiView addInputItem:[InputItemFactory makeShowMessageItemWithItemTitle:@""
                                                                      ItemName:@"银行"
                                                                   ItemContent:@"平安银行"
                                                                ItemSubContent:@"副标题"
                                                               ItemPlaceHolder:@"........."
                                                         ItemBeginEditCallback:^(UIView *itemView) {
                                                             
                                                         } ItemDidEditCallback:^(UIView *itemView) {
                                                             
                                                         } ItemDidEndCallback:^(UIView *itemView) {
                                                             
                                                         }]];
    
    [_multiView addInputItem:[InputItemFactory makeTextfiledItemWithItemTitle:@""
                                                                    ItemName:@"手机号码1"
                                                                 ItemContent:@""
                                                              ItemSubContent:@""
                                                             ItemPlaceHolder:@"请填写手机号码1..."
                                                       ItemBeginEditCallback:^(UIView *itemView) {
//                                                           LLog(@"itemView begin edit:%@\n" , itemView);
                                                       } ItemDidEditCallback:^(UIView *itemView) {
//                                                           LLog(@"itemView editing edit:%@\n" , itemView);
                                                       } ItemDidEndCallback:^(UIView *itemView) {
//                                                           LLog(@"itemView end edit:%@\n" , itemView);
                                                       }]];
    
    [_multiView addInputItem:[InputItemFactory makeTextfiledItemWithItemTitle:@""
                                                                     ItemName:@"手机号码2"
                                                                  ItemContent:@""
                                                               ItemSubContent:@""
                                                              ItemPlaceHolder:@"请填写手机号码2..."
                                                        ItemBeginEditCallback:^(UIView *itemView) {
                                                            
                                                        } ItemDidEditCallback:^(UIView *itemView) {
                                                            
                                                        } ItemDidEndCallback:^(UIView *itemView) {
                                                            
                                                        }]];
    
    [_multiView addInputItem:[InputItemFactory makeDatePickerViewItemWithItemTitle:@"" ItemName:@"请选择日期" ItemContent:@"...." ItemSubContent:@"" ItemPlaceHolder:@"...."
      ItemBeginEditCallback:^(UIView *inputView)
    {
        
    } ItemDidEditCallback:^(UIView *inputView) {
        
    } ItemDidEndCallback:^(UIView *inputView) {
        
    }]];
    
    
    //3.
    [_multiView addGetAllItemsValueCallback:^(NSArray *itemsValues) {
        
        NSLog(@"所有输入项OK：itemViews = %@\n", itemsValues);
        [[[UIAlertView alloc] initWithTitle:@"所有输入项都符合校验规则" message:[itemsValues componentsJoinedByString:@"\n"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Done", nil] show];
    } NotFillValueFirstItemCallback:^(InputItemView *itemView) {
        NSLog(@"最先不合法的itemView： = %@\n", itemView);
    }];
    
    //4.
    [self.view addSubview:_multiView];
    
    //5.
    [_multiView initSubInputItems];
    
//---------------------------------------------------------------------------
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)resignAllFocus {
    [_multiView cancelAllFucos];
}

- (void)click {
    ZHTableViewController *vc = [[ZHTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end