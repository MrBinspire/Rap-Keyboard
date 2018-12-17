//
//  VEKeyboardThemeManager.m
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 28/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import "VEKeyboardThemeManager.h"
#import "VEKeyboardTheme.h"
#import "VELightKeyboardTheme.h"


@implementation VEKeyboardThemeManager

+ (instancetype)sharedInstance
{
    static VEKeyboardThemeManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VEKeyboardThemeManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _avaibleThemes = @[[VELightKeyboardTheme new], [VEKeyboardTheme new]];
        _currentTheme = [_avaibleThemes firstObject];
    }
    return self;
}


@end
