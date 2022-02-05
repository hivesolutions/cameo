// Hive Cameo Framework
// Copyright (C) 2008-2022 Hive Solutions Lda.
//
// This file is part of Hive Cameo Framework.
//
// Hive Cameo Framework is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Cameo Framework is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Cameo Framework. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2022 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMLoginView.h"

@implementation HMLoginView

- (id)init {
    self = [super init];
    if(self) {
        [self doLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self doLayout];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self doLayout];
    }
    return self;
}

- (void)doLayout {
    if(_layout) { return; }
    _layout = YES;

    // starts the variable that will hold the vertical padding of the
    // contents in the login view
    CGFloat padding = 0;

    // initializes the frame size for the login view so that it
    // fills the entire screen as in accordance with the specification
    self.frame = CGRectMake(0, 0, 320, 568);

    // in case the current device is running ios 7 or above
    // need to apply the padding fix to the view (avoids overflow)
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        padding = 20;
    }

    // increments the padding with the top margin that is imposed
    // by the current screen/device
    padding += [HMScreen getTopMargin];

    // updates the basic values for the login view so that the
    // autoresizing mask enables it to be flexible in the width
    self.contentMode = UIViewContentModeCenter;
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    // retrieves the pattern image to be used and sets it in
    // the current view (should be able to change the background)
    UIImage *patternImage = [HMResources imageNamed:@"main-background-dark.png"];
    self.backgroundColor = [UIColor colorWithPatternImage:patternImage];

    // retrieves the current view's width, height and then devides it by two
    // to get half of the width (horizontal center)
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat widthH = self.frame.size.width / 2.0f;

    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(widthH - 150, padding, width - 20, 100)];
    logoView.image = [HMResources imageNamed:@"logo.png"];
    logoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;

    UIImageView *textFieldsView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100 + padding, width - 20, 80)];
    textFieldsView.image = [[HMResources imageNamed:@"text-fields.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    textFieldsView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

    HMTextField *usernameField = [[HMTextField alloc] initWithFrame:CGRectMake(20, 105 + padding, width - 40, 30)];
    usernameField.font = [UIFont fontWithName:@"Helvetica" size:14];
    usernameField.textColor = [UIColor whiteColor];
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameField.placeholder = [HMResources localizedString:@"UsernamePlaceholderText" withDefault:@"Username"];
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

    HMTextField *passwordField = [[HMTextField alloc] initWithFrame:CGRectMake(20, 145 + padding, width - 40, 30)];
    passwordField.secureTextEntry = YES;
    passwordField.font = [UIFont fontWithName:@"Helvetica" size:14];
    passwordField.textColor = [UIColor whiteColor];
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.placeholder = [HMResources localizedString:@"PasswordPlaceholderText" withDefault:@"Password"];
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

    UIButton *signinButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 192 + padding, 81, 42)];
    signinButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    signinButton.titleLabel.textColor = [UIColor whiteColor];
    signinButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
    signinButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [signinButton setTitle:[HMResources localizedString:@"Sign In" withDefault:@"Sign In"] forState:UIControlStateNormal];
    [signinButton setTitleShadowColor:[UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0] forState:UIControlStateNormal];
    [signinButton setBackgroundImage:[HMResources imageNamed:@"button.png"] forState:UIControlStateNormal];
    [signinButton setBackgroundImage:[HMResources imageNamed:@"button-pressed.png"] forState:UIControlStateHighlighted];

    UILabel *forgotLabel = [[UILabel alloc] initWithFrame:CGRectMake(99, 202 + padding, width - 109, 21)];
    forgotLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    forgotLabel.textColor = [UIColor whiteColor];
    forgotLabel.backgroundColor = [UIColor clearColor];
    forgotLabel.shadowColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
    forgotLabel.shadowOffset = CGSizeMake(1, 1);
    forgotLabel.text = [HMResources localizedString:@"Forgot your password ?" withDefault:@"Forgot your password ?"];
    forgotLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

    UILabel *copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, height - 41, width - 47, 21)];
    copyrightLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    copyrightLabel.textColor = [UIColor whiteColor];
    copyrightLabel.backgroundColor = [UIColor clearColor];
    copyrightLabel.shadowColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
    copyrightLabel.shadowOffset = CGSizeMake(1, 1);
    copyrightLabel.text = [HMResources localizedString:@"Copyright Hive Solutions 2008-2022" withDefault:@"Copyright Hive Solutions 2008-2022"];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

    [self addSubview:logoView];
    [self addSubview:textFieldsView];
    [self addSubview:usernameField];
    [self addSubview:passwordField];
    [self addSubview:signinButton];
    [self addSubview:forgotLabel];
    [self addSubview:copyrightLabel];

    self.logoView = logoView;
    self.usernameField = usernameField;
    self.passwordField = passwordField;
    self.signinButton = signinButton;
    self.forgotLabel = forgotLabel;
}

- (void)setLogo:(UIImage *)logo {
    _logo = logo;
    self.logoView.image = logo;
}

@end
