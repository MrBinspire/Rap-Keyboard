//
//  VERhymesView.h
//  Arbo
//
//  Created by Tomasz Dubik on 13/04/2017.
//  Copyright © 2017 VESTIONE Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VESugestionItem.h"

//@class VEContent;
@interface VERhymesView : UIView
- (void)addSingleWordSugestions:(NSString *)sugestionName;
- (void)addPhraseSugestions:(NSString *)sugestionName;
- (void)clearRhymes;
- (NSUInteger)numberOfSugestions;
- (void)updateLabels;
- (void)reorderItems;


@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) VEItemTappedCallback itemTappedCallback;
@property (nonatomic, copy) VEItemTappedCallback backPressedCallback;



@end
