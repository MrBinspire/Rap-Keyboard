//
//  UIColor+VEUtils.h
//  rides
//
//  Created by Tomasz Dubik on 24/03/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (VEUtils)

//dark theme
+ (UIColor *)ve_mainTextColor;
+ (UIColor *)ve_subTextColor;
+ (UIColor *)ve_backgroundColor;
+ (UIColor *)ve_buttonColor;
+ (UIColor *)ve_buttonActiveColor;

//light
+ (UIColor *)ve_lightMainTextColor;
+ (UIColor *)ve_lightSubTextColor;
+ (UIColor *)ve_lightBackgroundColor;
+ (UIColor *)ve_lightButtonColor;
+ (UIColor *)ve_lightButtonActiveColor;



+ (UIImage *)imageWithColor:(UIColor *)color;

@end
