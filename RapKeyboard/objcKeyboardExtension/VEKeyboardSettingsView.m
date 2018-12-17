//
//  VEKeyboardSettingsView.m
//  objcKeyboard
//
//  Created by Marcin Mierzejewski on 28/03/2018.
//  Copyright © 2018 Vestione. All rights reserved.
//

#import "VEKeyboardSettingsView.h"
#import "VEKeyboardThemeManager.h"
#import "VEKeyboardTheme.h"
#import "VELightKeyboardTheme.h"
#import "UIFont+VEUtils.h"

@interface VEKeyboardSettingsView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *themeLabel;
@property (nonatomic, strong) UILabel *feedbackLabel;

@property (nonatomic, strong) UISegmentedControl *themeSegmentControl;
@property (nonatomic, strong) UISegmentedControl *feedbackSegmentControl;



@end

@implementation VEKeyboardSettingsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])){
        [self prepareViews];
    }
    return self;
}

- (void)prepareViews
{
    
    _titleLabel = [UILabel new];
    [_titleLabel setText:@"Settings"];
    [_titleLabel setFont:[UIFont ve_fontBoldOfSize:18.0]];
    [self addSubview:_titleLabel];
    
    _themeLabel = [UILabel new];
    [_themeLabel setText:@"Theme"];
    [_themeLabel setFont:[UIFont ve_fontRegularOfSize:14.0]];
    [self addSubview:_themeLabel];

    _feedbackLabel = [UILabel new];
    [_feedbackLabel setText:@"Feedback"];
    [_feedbackLabel setFont:[UIFont ve_fontRegularOfSize:14.0]];
    [self addSubview:_feedbackLabel];

    
    _themeSegmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Dark",@"Light"]];
    [_themeSegmentControl addTarget:self action:@selector(themeControlValueDidChange:) forControlEvents:UIControlEventValueChanged];

    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"themeIndex"];
    [VEKeyboardThemeManager sharedInstance].currentTheme = [VEKeyboardThemeManager sharedInstance].avaibleThemes[index];
    if([[VEKeyboardThemeManager sharedInstance].currentTheme isKindOfClass:[VELightKeyboardTheme class]]){
        [_themeSegmentControl setSelectedSegmentIndex:1];
    }else{
        [_themeSegmentControl setSelectedSegmentIndex:0];
    }
    [self addSubview:_themeSegmentControl];

    _feedbackSegmentControl = [[UISegmentedControl alloc]initWithItems:@[@"On",@"Off"]];
    [_feedbackSegmentControl addTarget:self action:@selector(feedbackControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"noFeedback"]){
        [_feedbackSegmentControl setSelectedSegmentIndex:0];
    }else{
        [_feedbackSegmentControl setSelectedSegmentIndex:1];
    }
    [self addSubview:_feedbackSegmentControl];

    
    [self setupInitialConstraints];
    [[VEKeyboardThemeManager sharedInstance] addObserver:self forKeyPath:@"currentTheme" options:0 context:NULL];
    [self updateTheme];
}


- (void)setupInitialConstraints
{
    [_themeSegmentControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_themeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_feedbackLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_feedbackSegmentControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel,_themeSegmentControl,_themeLabel,_feedbackLabel,_feedbackSegmentControl);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_titleLabel]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_themeLabel]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_feedbackLabel]|" options:0 metrics:nil views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_themeSegmentControl(==120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_feedbackSegmentControl(==120)]" options:0 metrics:nil views:views]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_titleLabel(==22)]-5-[_themeLabel(==20)]-5-[_themeSegmentControl]-10-[_feedbackLabel(==20)]-5-[_feedbackSegmentControl]" options:0 metrics:nil views:views]];

    
}



-(void)themeControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            [VEKeyboardThemeManager sharedInstance].currentTheme = [[VEKeyboardThemeManager sharedInstance] avaibleThemes][0];
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"themeIndex"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            break;
        case 1:
            [VEKeyboardThemeManager sharedInstance].currentTheme = [[VEKeyboardThemeManager sharedInstance] avaibleThemes][1];
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"themeIndex"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            break;
    }
}

-(void)feedbackControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"noFeedback"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"noFeedback"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
    }
}


- (void)updateTheme
{
    [self setBackgroundColor:[[VEKeyboardThemeManager sharedInstance].currentTheme backgroundColor]];
    [_themeLabel setTextColor: [[VEKeyboardThemeManager sharedInstance].currentTheme mainTextColor]];
    [_titleLabel setTextColor: [[VEKeyboardThemeManager sharedInstance].currentTheme mainTextColor]];
    [_feedbackLabel setTextColor: [[VEKeyboardThemeManager sharedInstance].currentTheme mainTextColor]];
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

