//
//  UIFont+VEUtils.m
//  rides
//
//  Created by Tomasz Dubik on 6/13/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import "UIFont+VEUtils.h"

@implementation UIFont (VEUtils)


+ (UIFont *)ve_fontLightOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)ve_fontMediumOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (UIFont *)ve_fontThinOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:size];
}

+ (UIFont *)ve_fontRegularOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)ve_fontBoldOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont *)ve_fontBlackOfSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBlack];
}

@end
