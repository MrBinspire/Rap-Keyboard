//
//  UIColor+VEUtils.m
//  rides
//
//  Created by Tomasz Dubik on 24/03/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import "UIColor+VEUtils.h"

@implementation UIColor (VEUtils)


+ (UIColor *)ve_mainTextColor
{
    return [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];

}

+ (UIColor *)ve_subTextColor
{
    return [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];

}

+ (UIColor *)ve_backgroundColor
{
    return [UIColor colorWithRed:55/255.0 green:51/255.0 blue:50/255.0 alpha:1];

}

+ (UIColor *)ve_buttonColor
{
    return [UIColor colorWithRed:63/255.0 green:61/255.0 blue:60/255.0 alpha:1];
}

+ (UIColor *)ve_buttonActiveColor
{
    return [UIColor colorWithRed:83/255.0 green:81/255.0 blue:80/255.0 alpha:1];
}

//light theme
+ (UIColor *)ve_lightMainTextColor
{
    return [UIColor colorWithRed:(20)/255.0 green:(20)/255.0 blue:(20)/255.0 alpha:1];
}

+ (UIColor *)ve_lightSubTextColor
{
    return [UIColor colorWithRed:(255-150)/255.0 green:(255-150)/255.0 blue:(255-150)/255.0 alpha:1];
    
}

+ (UIColor *)ve_lightBackgroundColor
{
    return [UIColor colorWithRed:(202)/255.0 green:(205)/255.0 blue:(212)/255.0 alpha:1];
    
}

+ (UIColor *)ve_lightButtonColor
{
    return [UIColor colorWithRed:(255)/255.0 green:(255)/255.0 blue:(255)/255.0 alpha:1];
}

+ (UIColor *)ve_lightButtonActiveColor
{
    return [UIColor colorWithRed:(255-23)/255.0 green:(255-21)/255.0 blue:(255-20)/255.0 alpha:1];
}



+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
