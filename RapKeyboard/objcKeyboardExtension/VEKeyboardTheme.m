//
//  VEKeyboardTheme.m
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 27/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import "VEKeyboardTheme.h"
#import "UIColor+VEUtils.h"

@implementation VEKeyboardTheme
- (UIColor *)mainTextColor
{
    return [UIColor ve_mainTextColor];
}

- (UIColor *)subTextColor
{
    return [UIColor ve_subTextColor];
    
}

- (UIColor *)backgroundColor
{
    return [UIColor ve_backgroundColor];
    
}

- (UIColor *)buttonColor
{
    return [UIColor ve_buttonColor];
}

- (UIColor *)buttonActiveColor
{
    return [UIColor ve_buttonActiveColor];
}
- (UIColor *)buttonAlternativeColor
{
    return [UIColor colorWithRed:0/255.0 green:111/255.0 blue:255/255.0 alpha:1];

}

- (UIColor *)buttonGrayColor
{
    return [UIColor colorWithRed:(255-165)/255.0 green:(255-170)/255.0 blue:(255-180)/255.0 alpha:1];
}

@end
