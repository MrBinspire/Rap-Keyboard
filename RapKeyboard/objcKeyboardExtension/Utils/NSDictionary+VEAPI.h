//
//  NSDictionary+VEAPI.h
//  rides
//
//  Created by Tomasz Dubik on 16/12/14.
//  Copyright (c) 2014 Tomasz Dubik Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (VEAPI)

- (NSString *)errorMessage;
- (NSString *)urlWithScale;
- (BOOL)hasValidObjectForKey:(NSString *)key;
- (id)validObjectForKey:(NSString *)key;

@end
