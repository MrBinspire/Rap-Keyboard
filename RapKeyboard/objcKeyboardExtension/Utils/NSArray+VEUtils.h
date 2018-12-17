//
//  NSArray+VEUtils.h
//  rides
//
//  Created by Tomasz Dubik on 06/01/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (VEUtils)

- (NSMutableDictionary *)cacheWithKeyPath:(NSString *)keyPath;

@end
