//
//  InputItemFactory.h
//  InputKit
//
//  Created by sfpay on 15/3/4.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputItem.h"


@interface InputItemFactory : NSObject

+ (InputItem *) makeShowMessageItemWithItemTitle:(NSString *) itemTitle
                                        ItemName:(NSString *) itemName
                                     ItemContent:(NSString *) itemContent
                                  ItemSubContent:(NSString *) itemSubContent
                                 ItemPlaceHolder:(NSString *) itemPlaceHolder
                           ItemBeginEditCallback:(ItemBeginEditCallback) beginEdit
                             ItemDidEditCallback:(ItemEditingCallback) didEdit
                              ItemDidEndCallback:(ItemEndEditCallback) endEdit;


+ (InputItem *) makeTextfiledItemWithItemTitle:(NSString *) itemTitle
                                      ItemName:(NSString *) itemName
                                   ItemContent:(NSString *) itemContent
                                ItemSubContent:(NSString *) itemSubContent
                               ItemPlaceHolder:(NSString *) itemPlaceHolder
                         ItemBeginEditCallback:(ItemBeginEditCallback) beginEdit
                           ItemDidEditCallback:(ItemEditingCallback) didEdit
                            ItemDidEndCallback:(ItemEndEditCallback) endEdit;


+ (InputItem *) makeDatePickerViewItemWithItemTitle:(NSString *) itemTitle
                                           ItemName:(NSString *) itemName
                                        ItemContent:(NSString *) itemContent
                                     ItemSubContent:(NSString *) itemSubContent
                                    ItemPlaceHolder:(NSString *) itemPlaceHolder
                              ItemBeginEditCallback:(ItemBeginEditCallback) beginEdit
                                ItemDidEditCallback:(ItemEditingCallback) didEdit
                                 ItemDidEndCallback:(ItemEndEditCallback) endEdit;


@end
