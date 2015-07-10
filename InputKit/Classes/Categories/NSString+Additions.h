//
//  NSString+Additions.h
//  InputKit
//
//  Created by xiongzenghui on 15/3/5.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)


/**
 *  计算文字尺寸
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)xzh_sizefont:(UIFont *)font
               maxSize:(CGSize)maxSize;


- (float) heightForFontSize:(float)fontSize andWidth:(float)width;
@end
