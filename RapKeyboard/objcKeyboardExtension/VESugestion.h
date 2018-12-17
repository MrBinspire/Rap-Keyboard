//
//  VESugestion.h
//  Arbo
//
//  Created by Marcin Mierzejewski on 21/08/2017.
//  Copyright © 2017 VESTIONE Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VEContent;
@interface VESugestion : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray <VEContent *>*contents;

@end
