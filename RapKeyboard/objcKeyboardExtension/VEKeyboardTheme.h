//
//  VEKeyboardTheme.h
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 27/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VEKeyboardTheme : NSObject
- (UIColor *)mainTextColor;
- (UIColor *)subTextColor;
- (UIColor *)backgroundColor;
- (UIColor *)buttonColor;
- (UIColor *)buttonAlternativeColor;
- (UIColor *)buttonActiveColor;
- (UIColor *)buttonGrayColor;
@end
