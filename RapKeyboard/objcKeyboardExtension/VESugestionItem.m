//
//  VESugestionItem.m
//  Arbo
//
//  Created by Tomasz Dubik on 21/04/2017.
//  Copyright © 2017 VESTIONE Sp. z o.o. All rights reserved.
//

#import "VESugestionItem.h"
#import "VESugestion.h"
#import "VEKeyboardThemeManager.h"
#import "VEKeyboardTheme.h"

static CGFloat kVESugestionMargin = 5.0;

@interface VESugestionItem()

@property (nonatomic, strong) UILabel *sugestionNameLabel;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) VESugestionType sugestionType;
@property (nonatomic, strong) VEKeyboardTheme *theme;

@end

@implementation VESugestionItem

- (instancetype)initWithSugestionName:(NSString *)name type:(VESugestionType)type
{
    if((self = [super initWithFrame:CGRectZero])){
        if (name == nil || [name length] == 0) {
            return nil;
        }
        
//        name = [VESugestion santizeSugestionName:name];
        _sugestionType = type;
        _backgroundView = [UIView new];
        [_backgroundView.layer setCornerRadius:15.0];
        [self addSubview:_backgroundView];
        
        _sugestionNameLabel = [UILabel new];
        if(type == VESugestionTypeSugest){
//            [_sugestionNameLabel setTextColor:[UIColor ve_purplishGreyColor]];
        }
//        [_sugestionNameLabel setFont:[UIFont ve_fontLightOfSize:14.0]];
//        [_sugestionNameLabel setText:[NSString stringWithFormat:@"%@",[name lowercaseString]]];
        [_sugestionNameLabel setText:name];
        [_sugestionNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_sugestionNameLabel];
        
        [self setupInitialConstraints];

        [[VEKeyboardThemeManager sharedInstance] addObserver:self forKeyPath:@"currentTheme" options:0 context:NULL];
        [self updateTheme];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, [VESugestionItem widthForName:name], self.frame.size.height)];
    }
    return self;
}

- (void)setupInitialConstraints
{
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sugestionNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_backgroundView, _sugestionNameLabel);
    NSDictionary *metrics = @{@"margin" : @(kVESugestionMargin)};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==margin)-[_sugestionNameLabel]-(==margin)-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_sugestionNameLabel]|" options:0 metrics:metrics views:views]];
}

- (void)tapped:(UITapGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        if(self.sugestionTappedCallback){
            self.sugestionTappedCallback();
        }
    }
}

- (NSString *)sugestionName
{
    return _sugestionNameLabel.text;//[VESugestion santizeSugestionName:_sugestionNameLabel.text];
}

- (VESugestionType)type
{
    return _sugestionType;
}

+ (CGFloat)widthForName:(NSString *)name
{
    CGFloat textWidth = [[name uppercaseString] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 44.0) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.width;
    textWidth += 2*kVESugestionMargin + 4.0 + 8.0;
    
    return ceilf(textWidth);
}


- (void)updateTheme
{
    [_backgroundView setBackgroundColor:[[[VEKeyboardThemeManager sharedInstance] currentTheme] buttonColor]];
    [_sugestionNameLabel setTextColor:[[[VEKeyboardThemeManager sharedInstance] currentTheme] mainTextColor]];
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
