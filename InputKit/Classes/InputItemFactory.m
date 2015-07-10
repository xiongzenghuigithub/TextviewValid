//
//  InputItemFactory.m
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import "InputItemFactory.h"


@implementation InputItemFactory

+ (InputItem *) instanceWithTitle:(NSString *) title
                             Name:(NSString *) name
                          Content:(NSString *) content
                       SubContent:(NSString *) subContent
                      PlaceHolder:(NSString *) placeHolder
                BeginEditCallback:(ItemBeginEditCallback) begin
                  EditingCallback:(ItemEditingCallback) editing
                  EndEditCallback:(ItemEndEditCallback) end
{
    InputItem *item = [[InputItem alloc] init];
    item.itemTitie = title;
    item.itemName = name;
    item.itemContent = content;
    item.itemSubContent = subContent;
    item.itemPlaceHolder = placeHolder;
    
    [item addItemBeginCallback:begin
           ItemEditingCallback:editing
           ItemEndEditCallback:end
     ];
    
    return item;
}

+ (InputItem *) makeShowMessageItemWithItemTitle:(NSString *) itemTitle
                                        ItemName:(NSString *) itemName
                                     ItemContent:(NSString *) itemContent
                                  ItemSubContent:(NSString *) itemSubContent
                                 ItemPlaceHolder:(NSString *) itemPlaceHolder
                           ItemBeginEditCallback:(ItemBeginEditCallback) beginEdit
                             ItemDidEditCallback:(ItemEditingCallback) didEdit
                              ItemDidEndCallback:(ItemEndEditCallback) endEdit
{
    InputItem *item = [self instanceWithTitle:itemTitle
                                         Name:itemName
                                      Content:itemContent
                                   SubContent:itemSubContent
                                  PlaceHolder:itemPlaceHolder
                            BeginEditCallback:beginEdit
                              EditingCallback:didEdit
                              EndEditCallback:endEdit];
    
    item.inputType = InputItemTypeLabel;
    item.isNeedValidate = NO;
    return item;
}

+ (InputItem *) makeTextfiledItemWithItemTitle:(NSString *) itemTitle
                                      ItemName:(NSString *) itemName
                                   ItemContent:(NSString *) itemContent
                                ItemSubContent:(NSString *) itemSubContent
                               ItemPlaceHolder:(NSString *) itemPlaceHolder
                         ItemBeginEditCallback:(ItemBeginEditCallback) beginEdit
                           ItemDidEditCallback:(ItemEditingCallback) didEdit
                            ItemDidEndCallback:(ItemEndEditCallback) endEdit
{
    InputItem *item = [self instanceWithTitle:itemTitle
                                         Name:itemName
                                      Content:itemContent
                                   SubContent:itemSubContent
                                  PlaceHolder:itemPlaceHolder
                            BeginEditCallback:beginEdit
                              EditingCallback:didEdit
                              EndEditCallback:endEdit];
    
    item.inputType = InputItemTypeTextfiled;
    item.isNeedValidate = YES;
    return item;
}

+ (InputItem *) makeDatePickerViewItemWithItemTitle:(NSString *) itemTitle
                                           ItemName:(NSString *) itemName
                                        ItemContent:(NSString *) itemContent
                                     ItemSubContent:(NSString *) itemSubContent
                                    ItemPlaceHolder:(NSString *) itemPlaceHolder
                              ItemBeginEditCallback:(ItemBeginEditCallback) beginEdit
                                ItemDidEditCallback:(ItemEditingCallback) didEdit
                                 ItemDidEndCallback:(ItemEndEditCallback) endEdit
{
    InputItem *item = [self instanceWithTitle:itemTitle
                                         Name:itemName
                                      Content:itemContent
                                   SubContent:itemSubContent
                                  PlaceHolder:itemPlaceHolder
                            BeginEditCallback:beginEdit
                              EditingCallback:didEdit
                              EndEditCallback:endEdit];
    
    item.inputType = InputItemTypeDatePickerView;
    item.isNeedValidate = YES;
    return item;
}

@end
