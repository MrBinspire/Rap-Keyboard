//
//  VEKeyboardThemeManager.h
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 28/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VEKeyboardTheme.h"
@interface VEKeyboardThemeManager : NSObject
+ (instancetype)sharedInstance;


@property (nonatomic, strong) VEKeyboardTheme *currentTheme;
@property (nonatomic, strong) NSArray<VEKeyboardTheme *> *avaibleThemes;

@end
