//
//  VESugestionItem.h
//  Arbo
//
//  Created by Tomasz Dubik on 21/04/2017.
//  Copyright © 2017 VESTIONE Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "VEGlobalDef.h"
typedef void(^VEItemTappedCallback)(NSString *val);
typedef void(^VESimpleCallback)(void);

typedef NS_ENUM(NSInteger, VESugestionType)
{
    VESugestionTypeInfo = 0,
    VESugestionTypeWitClose,
    VESugestionTypeSugest,

};

@interface VESugestionItem : UIControl

@property (nonatomic, copy) VESimpleCallback sugestionTappedCallback;
@property (nonatomic, strong, readonly) NSString *sugestionName;
@property (nonatomic, assign, readonly) VESugestionType type;

- (instancetype)initWithSugestionName:(NSString *)name type:(VESugestionType)type;

+ (CGFloat)widthForName:(NSString *)name;

@end
