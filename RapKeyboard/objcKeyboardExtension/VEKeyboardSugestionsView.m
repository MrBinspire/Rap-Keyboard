//
//  VEKeyboardSugestionsView.m
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 29/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import "VEKeyboardSugestionsView.h"
#import "VEKeyboardThemeManager.h"
#import "VESugestionItem.h"
#import "VEKeyboardTheme.h"


@interface VEKeyboardSugestionsView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIView *> *views;


@end

@implementation VEKeyboardSugestionsView
CGFloat const KEYBOARD_SUGESTION_VIEW_HEIGHT = 35.0;


- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])){
        self.views = [NSMutableArray new];
        [self prepareViews];
    }
    return self;
}

- (void)prepareViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrollView setPagingEnabled:NO];
    [self addSubview:_scrollView];

    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics:nil views:views]];

    [[VEKeyboardThemeManager sharedInstance] addObserver:self forKeyPath:@"currentTheme" options:0 context:NULL];
    [self updateTheme];
}

- (void)setItems:(NSArray <NSString *>*)items
{
    _items = items;
    for (UIView *item in self.views) {
        [item removeFromSuperview];
    }
    
    self.views = [NSMutableArray new];
    
    CGFloat x = 10;
    for (NSString *item in items) {
        VESugestionItem *view = [[VESugestionItem alloc] initWithSugestionName:item type:VESugestionTypeSugest];
        [self.scrollView addSubview:view];
        [view setSugestionTappedCallback:^{
            self.itemTappedCallback(item);
        }];
        [view setFrame:CGRectMake(x,5, view.frame.size.width, self.frame.size.height - 5)];
        [self.views addObject:view];
        x = x + view.frame.size.width + 14;
    }
    [self.scrollView setContentSize:CGSizeMake(x, self.scrollView.frame.size.height)];
    
}

- (void)updateTheme
{
    [self setBackgroundColor:[[VEKeyboardThemeManager sharedInstance].currentTheme backgroundColor]];
//    for (VESugestionItem *item in self.views) {
////        
//    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updateTheme];
}

- (void)dealloc
{
    @try {
        [[VEKeyboardThemeManager sharedInstance] removeObserver:self forKeyPath:@"currentTheme" context:NULL];
    }
    @catch(NSException *e) {
        NSLog(@"%@",e);
    }
}

- (void)reorderItems
{
    self.items = _items;
}

- (NSInteger)suggestionCount
{
    return [self.views count];
}



@end
