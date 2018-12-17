//
//  VESugestionManager.m
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 22/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import "VESugestionManager.h"
@interface VESugestionManager()
@property (nonatomic, strong) NSArray *rhymes;

@end

@implementation VESugestionManager



+ (instancetype)sharedInstance
{
    static VESugestionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VESugestionManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareFromFile];
    }
    return self;
}

- (NSArray<NSString *>*)rhymesForWord:(NSString *)word
{
    NSMutableArray *result = [NSMutableArray new];
    for (NSArray *rPack in _rhymes) {
        for (NSString *wordFromRPack in rPack) {
            NSArray *array = [wordFromRPack componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            BOOL lastWordMatch = NO;
            if([array count] > 1){
                NSString *lastWord = [array lastObject];
                if([lastWord caseInsensitiveCompare:word] == NSOrderedSame){
                    lastWordMatch = YES;
                }
            }
            if([wordFromRPack caseInsensitiveCompare:word] == NSOrderedSame || lastWordMatch){
                NSArray *filtered = [VESugestionManager filterToSingleWordsOnly:rPack];
                [result addObjectsFromArray:filtered];
            }
        }
        
    }
    
    return result;
}

- (NSArray<NSString *>*)rhymesPhrasesForWord:(NSString *)word
{
    NSMutableArray *result = [NSMutableArray new];
    for (NSArray *rPack in _rhymes) {
        for (NSString *phraseFromRPack in rPack) {
            NSArray *array = [phraseFromRPack componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
            if([array count] > 1){
                NSString *lastWorld = [array lastObject];
                if([lastWorld caseInsensitiveCompare:word] == NSOrderedSame ){
                    NSArray *filtered = [VESugestionManager filterToPhrasesOnly:rPack];
                    [result addObjectsFromArray:filtered];
                }
            }
         
        }
        
    }
    
    return result;
}


+ (NSArray <NSString *>*)filterToSingleWordsOnly:(NSArray <NSString *>*)rPack
{
    NSMutableArray *result = [NSMutableArray new];
    for (NSString *phrase in rPack) {
        NSArray *array = [phrase componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([array count] < 2){
            [result addObject:phrase];
        } else {
            [result addObject:[array lastObject]];//add also last world - it should also rhyme
        }
    }
    
    //remove duplicates
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:result];
    NSArray *withoutDuplicates = [orderedSet array];

    return withoutDuplicates;
}

+ (NSArray <NSString *>*)filterToPhrasesOnly:(NSArray <NSString *>*)rPack
{
    NSMutableArray *result = [NSMutableArray new];
    for (NSString *phrase in rPack) {
        NSArray *array = [phrase componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([array count] >= 2){
            [result addObject:phrase];
        }
    }
    //remove duplicates
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:result];
    NSArray *withoutDuplicates = [orderedSet array];
    
    return withoutDuplicates;
}


//- (NSArray<NSString *>*)phrasesForWord:(NSString *)word
//{
//    NSMutableArray *result = [NSMutableArray new];
//
//    prefix = [prefix lowercaseString];
//    if(!prefix){
//        return result;
//    }
//
//    for (NSString *word in _phrases) {
//        if([self string:word hasPrefix:prefix caseInsensitive:YES] && ![word isEqualToString:prefix]){
//            [result addObject:word];
//        }
//    }
//
//    return result;
//}



//- (NSArray<NSString *>*)sugestionsForPrefix:(NSString *)prefix
//{
//    NSMutableArray *result = [NSMutableArray new];
//
//    prefix = [prefix lowercaseString];
//    if(!prefix){
//        return result;
//    }
//
//    for (NSString *word in _phrases) {
//        if([self string:word hasPrefix:prefix caseInsensitive:YES] && ![word isEqualToString:prefix]){
//            [result addObject:word];
//        }
//    }
//
//    return result;
//}

- (BOOL) string:(NSString *)string
      hasPrefix:(NSString *)prefix
caseInsensitive:(BOOL)caseInsensitive
{
    
    if (!caseInsensitive)
        return [string hasPrefix:prefix];
    
    const NSStringCompareOptions options = NSAnchoredSearch|NSCaseInsensitiveSearch;
    NSRange prefixRange = [string rangeOfString:prefix
                                        options:options];
    return prefixRange.location == 0 && prefixRange.length > 0;
}



- (void)prepareFromFile
{
    NSString *path = [NSBundle.mainBundle pathForResource:@"rhymes" ofType:@"json"];
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path] options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    _rhymes = [json objectForKey:@"rhymes"];
    
}
@end

