//
//  VEKeyboardSugestionsView.h
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 29/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VESugestionItem.h"



@interface VEKeyboardSugestionsView : UIView
extern CGFloat const KEYBOARD_SUGESTION_VIEW_HEIGHT;

@property (nonatomic, strong) NSArray <NSString *>* items;
- (NSInteger)suggestionCount;
@property (nonatomic, copy) VEItemTappedCallback itemTappedCallback;
- (void)reorderItems;

@end
