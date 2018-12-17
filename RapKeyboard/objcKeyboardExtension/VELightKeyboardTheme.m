//
//  VELightKeyboardTheme.m
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 27/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import "VELightKeyboardTheme.h"
#import "UIColor+VEUtils.h"

@implementation VELightKeyboardTheme
- (UIColor *)mainTextColor
{
    return [UIColor ve_lightMainTextColor];
}

- (UIColor *)subTextColor
{
    return [UIColor ve_lightSubTextColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor ve_lightBackgroundColor];
}

- (UIColor *)buttonColor
{
    return [UIColor ve_lightButtonColor];
}

- (UIColor *)buttonActiveColor
{
    return [UIColor ve_lightButtonActiveColor];
}

- (UIColor *)buttonAlternativeColor
{
    return [UIColor colorWithRed:0/255.0 green:111/255.0 blue:255/255.0 alpha:1];
}

- (UIColor *)buttonGrayColor
{
    return [UIColor colorWithRed:165/255.0 green:170/255.0 blue:180/255.0 alpha:1];
}
@end
