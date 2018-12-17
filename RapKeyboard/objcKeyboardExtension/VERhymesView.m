//
//  VERhymesView.m
//  Arbo
//
//  Created by Tomasz Dubik on 13/04/2017.
//  Copyright © 2017 VESTIONE Sp. z o.o. All rights reserved.
//

#import "VERhymesView.h"
#import "VESugestionItem.h"
#import "VESugestion.h"
#import "VESugestionManager.h"
#import "VEKeyboardTheme.h"
#import "VEKeyboardThemeManager.h"
#import "UIFont+VEUtils.h"
#import "UIColor+VEUtils.h"

static CGFloat kVESugestionItemMargin = 10.0;
static CGFloat kVESugestionItemHeight = 30.0;

@interface VERhymesView ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *sugestionsTitleLabel;
@property (nonatomic, strong) UILabel *phraseSugestionsTitleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *singleWordSugestions;
@property (nonatomic, strong) NSMutableArray *singleWordSugestionsViews;
@property (nonatomic, strong) NSMutableArray *phrasesSugestions;
@property (nonatomic, strong) NSMutableArray *phrasesSugestionsViews;
@property (nonatomic, strong) NSLayoutConstraint *phraseTitleTopConstraint;
@property (nonatomic, strong) VEKeyboardTheme *theme;
@property (nonatomic, strong) UIButton *backButton;


@end

@implementation VERhymesView

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])){
        _singleWordSugestions = [NSMutableArray array];
        _singleWordSugestionsViews = [NSMutableArray array];
        _phrasesSugestions = [NSMutableArray array];
        _phrasesSugestionsViews = [NSMutableArray array];

        [self prepareViews];
    }
    return self;
}

- (void)prepareViews
{
    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_contentView];
    
    __weak typeof(self) weakSelf = self;
    
    _scrollView = [[UIScrollView alloc] init];
//    _scrollView.delaysContentTouches = NO;
    _scrollView.backgroundColor = UIColor.redColor;
    
    [self.contentView addSubview:_scrollView];
    
    _sugestionsTitleLabel = [[UILabel alloc] init];
    _sugestionsTitleLabel.text = @"Rhymes";
    [_sugestionsTitleLabel setFont:[UIFont ve_fontBoldOfSize:18.0]];
//    [_sugestionsTitleLabel setContentMode:UIViewContentModeScaleAspectFill];
    [self.scrollView addSubview:_sugestionsTitleLabel];
    
    _phraseSugestionsTitleLabel = [[UILabel alloc] init];
    _phraseSugestionsTitleLabel.text = @"Phrase rhymes";
    [_phraseSugestionsTitleLabel setFont:[UIFont ve_fontBoldOfSize:18.0]];
    [self.scrollView addSubview:_phraseSugestionsTitleLabel];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"Back to keyboard" forState:UIControlStateNormal];
    [_backButton.titleLabel setFont:[UIFont ve_fontBoldOfSize:18.0]];
    _backButton.layer.cornerRadius = 4.0;
    _backButton.clipsToBounds = YES;
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_backButton];
    
    [self setupInitialConstraints];

    [[VEKeyboardThemeManager sharedInstance] addObserver:self forKeyPath:@"currentTheme" options:0 context:NULL];
    
    [self updateTheme];
    
}

- (void)setupInitialConstraints
{
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sugestionsTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_phraseSugestionsTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView, _sugestionsTitleLabel, _contentView, _phraseSugestionsTitleLabel, _backButton);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_backButton(==30)]-2-|" options:0 metrics:nil views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_backButton(==170)]-8-|" options:0 metrics:nil views:views]];

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_sugestionsTitleLabel]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_sugestionsTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_sugestionsTitleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0.0 constant:20.0]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_phraseSugestionsTitleLabel]|" options:0 metrics:nil views:views]];
    _phraseTitleTopConstraint = [NSLayoutConstraint constraintWithItem:_phraseSugestionsTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:80.0];
    [self.contentView addConstraint:_phraseTitleTopConstraint];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_phraseSugestionsTitleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0.0 constant:20.0]];

    
    

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics:nil views:views]];


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics:nil views:views]];
    

}

#pragma mark - inserrting sugestions

- (void)addSelectedSugestion:(VESugestionItem *)sugestionItem
{
    BOOL isPhrase = [[sugestionItem.sugestionName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] count] > 1;
    
    CGRect sugestionFrame = [self rectForSugestionItem:sugestionItem];
    [sugestionItem setFrame:sugestionFrame];
    [_scrollView addSubview:sugestionItem];

    if(isPhrase){
        [_phrasesSugestionsViews addObject:sugestionItem];
        [_phrasesSugestions addObject:sugestionItem.sugestionName];
    } else {
        [_singleWordSugestionsViews addObject:sugestionItem];
        [_singleWordSugestions addObject:sugestionItem.sugestionName];
    }
    
    __weak VESugestionItem *weakSugestionItem = sugestionItem;
    __weak typeof(self) weakSelf = self;

    
    [sugestionItem setSugestionTappedCallback:^(){
        if(weakSelf.itemTappedCallback){
            NSString *value = weakSugestionItem.sugestionName;
            weakSelf.itemTappedCallback(value);
        }
    }];
    
    //animate change height
    [self layoutIfNeeded];
//    _sugestionViewsHeightConstraint.constant = [self scrollViewHeight];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, [self scrollViewHeight] + 90);
    [UIView animateWithDuration:.2 animations:^{
        [self layoutIfNeeded];
    }];
    
}

- (CGFloat)spaceLeftInRow:(VESugestionItem *)sugestionItem
{
    CGRect rect = [self rectForSugestionItem:sugestionItem];
    CGFloat maxX = rect.origin.x + rect.size.width + kVESugestionItemMargin * 2;
    return _scrollView.frame.size.width - maxX;
}

- (CGRect)rectForSugestionItem:(VESugestionItem *)sugestionItem
{
    BOOL isPhrase = [[sugestionItem.sugestionName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] count] > 1;

    VESugestionItem *lastItem = [_singleWordSugestionsViews lastObject];
    if(isPhrase){
        lastItem = [_phrasesSugestionsViews lastObject];
    }

    if(!isPhrase){
        if([_singleWordSugestionsViews containsObject:sugestionItem]){
            long indexOfPreviousItem = [_singleWordSugestionsViews indexOfObject:sugestionItem]-1L;
            if(indexOfPreviousItem < 0){
                lastItem = nil;
            } else {
                lastItem = _singleWordSugestionsViews[indexOfPreviousItem];
            }
        }
    } else {
        if([_phrasesSugestionsViews containsObject:sugestionItem]){
            long indexOfPreviousItem = [_phrasesSugestionsViews indexOfObject:sugestionItem]-1L;
            if(indexOfPreviousItem < 0){
                lastItem = nil;
            } else {
                lastItem = _phrasesSugestionsViews[indexOfPreviousItem];
            }
        }

    }
        
    
    CGRect result = CGRectZero;
    CGFloat width = [VESugestionItem widthForName:sugestionItem.sugestionName];
    if(!lastItem){
        if(!isPhrase){
            result = CGRectMake(kVESugestionItemMargin + 0, kVESugestionItemMargin + 26, width, kVESugestionItemHeight);
        } else {
            CGRect lastSingleItemFrame = [[[self singleWordSugestionsViews] lastObject] frame];
            CGFloat additionalYOffset = CGRectGetMaxY(lastSingleItemFrame) + 4;
            result = CGRectMake(kVESugestionItemMargin + 0, kVESugestionItemMargin + 26 + additionalYOffset, width, kVESugestionItemHeight);
        }
    }else{
        CGRect prevItemFrame = lastItem.frame;
        CGFloat maxX = CGRectGetMaxX(prevItemFrame) + kVESugestionItemMargin + width;
        if(maxX > self.frame.size.width - kVESugestionItemMargin * 2){
            //New line;
            CGFloat y = prevItemFrame.origin.y + kVESugestionItemMargin + kVESugestionItemHeight;
            result = CGRectMake(kVESugestionItemMargin, y, width, kVESugestionItemHeight);
        } else {
            //same line
            result = CGRectMake(CGRectGetMaxX(prevItemFrame) + kVESugestionItemMargin, prevItemFrame.origin.y, width, kVESugestionItemHeight);
        }
    }
    return result;
}

- (CGFloat)scrollViewHeight
{
    CGRect lastSugestionFrame = [self rectForSugestionItem:[_singleWordSugestionsViews lastObject]];
    CGRect phraseLastSugestionFrame = [self rectForSugestionItem:[_phrasesSugestionsViews lastObject]];
    return MAX(CGRectGetMaxY(lastSugestionFrame),CGRectGetMaxY(phraseLastSugestionFrame));
}

- (void)reorderItems
{
    [UIView animateWithDuration:.2 animations:^{
        for (VESugestionItem *sugestionItem in self.singleWordSugestionsViews) {
            CGRect frame = [self rectForSugestionItem:sugestionItem];
            sugestionItem.frame = frame;
        }

        for (VESugestionItem *sugestionItem in self.phrasesSugestionsViews) {
            CGRect frame = [self rectForSugestionItem:sugestionItem];
            sugestionItem.frame = frame;
        }

    }];

}

- (void)clearRhymes
{
    for (UIView *view in _singleWordSugestionsViews) {
        [view removeFromSuperview];
    }
    
    [_singleWordSugestionsViews removeAllObjects];
    [_singleWordSugestions removeAllObjects];

    [_phrasesSugestionsViews removeAllObjects];
    [_phrasesSugestions removeAllObjects];

}




- (void)addSingleWordSugestions:(NSString *)sugestionName
{
    NSString *sugestion = [sugestionName lowercaseString];
    if(![self.singleWordSugestions containsObject:sugestion] && [sugestion length]>0){
        VESugestionItem *sugestionItem = [[VESugestionItem alloc] initWithSugestionName:sugestion type:VESugestionTypeWitClose];
        [self addSelectedSugestion:sugestionItem];
    }
    //    [self reorderItems];
}

- (void)addPhraseSugestions:(NSString *)sugestion
{
    if(![self.phrasesSugestions containsObject:sugestion] && [sugestion length]>0){
        VESugestionItem *sugestionItem = [[VESugestionItem alloc] initWithSugestionName:sugestion type:VESugestionTypeWitClose];
        [self addSelectedSugestion:sugestionItem];
    }
    //    [self reorderItems];
}


- (NSUInteger)numberOfSugestions
{
    return [self.singleWordSugestionsViews count] + [self.phrasesSugestionsViews count];
}

- (void)updateLabels
{
    _sugestionsTitleLabel.hidden = YES;
    _phraseSugestionsTitleLabel.hidden = YES;

    
    if([self.singleWordSugestionsViews count] > 0){
        _sugestionsTitleLabel.hidden = NO;
    }
    if([self.phrasesSugestionsViews count] > 0){
        _phraseSugestionsTitleLabel.hidden = NO;
    }
    
    if ([self.singleWordSugestionsViews count] + [self.phrasesSugestionsViews count] == 0){
        _sugestionsTitleLabel.hidden = NO;
    }
    
    CGRect lastSugestionFrame = [self rectForSugestionItem:[_singleWordSugestionsViews lastObject]];
    _phraseTitleTopConstraint.constant = CGRectGetMaxY(lastSugestionFrame) + 10;
   
    
    
}

- (void)backPressed
{
    if(self.backPressedCallback){
        _backPressedCallback(@"");
    }
}

- (void)updateTheme
{
    [_scrollView setBackgroundColor:[[[VEKeyboardThemeManager sharedInstance] currentTheme] backgroundColor]];
    _sugestionsTitleLabel.textColor = [[[VEKeyboardThemeManager sharedInstance] currentTheme] mainTextColor];
    _phraseSugestionsTitleLabel.textColor = [[[VEKeyboardThemeManager sharedInstance] currentTheme] mainTextColor];
    [_backButton setTitleColor:[[[VEKeyboardThemeManager sharedInstance] currentTheme] mainTextColor] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIColor imageWithColor:[[[VEKeyboardThemeManager sharedInstance] currentTheme] buttonAlternativeColor]] forState:UIControlStateNormal];

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

@end
