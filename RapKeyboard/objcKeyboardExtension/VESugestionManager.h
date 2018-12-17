//
//  VESugestionManager.h
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 22/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VESugestionManager : NSObject
- (NSArray<NSString *>*)rhymesForWord:(NSString *)word;
- (NSArray<NSString *>*)rhymesPhrasesForWord:(NSString *)word;

+ (instancetype)sharedInstance;
@end
