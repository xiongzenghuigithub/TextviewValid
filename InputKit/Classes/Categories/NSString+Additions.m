//
//  NSString+Additions.m
//  InputKit
//
//  Created by xiongzenghui on 15/3/5.
//  Copyright (c) 2015年 zain. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (CGSize)xzh_sizefont:(UIFont *)font
               maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
    
}

- (float) heightForFontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

@end
