// Hive Cameo Framework
// Copyright (C) 2008-2012 Hive Solutions Lda.
//
// This file is part of Hive Cameo Framework.
//
// Hive Cameo Framework is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Cameo Framework is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Cameo Framework. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

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
    
    self.frame = CGRectMake(0, 0, 320, 568);
    self.contentMode = UIViewContentModeCenter;
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // retrieves the pattern image to be used and sets it in
    // the current view (should be able to change the background)
    UIImage *patternImage = [HMResources image:@"main-background-dark" type:@"png"];
    self.backgroundColor = [UIColor colorWithPatternImage:patternImage];

    CGFloat width = self.frame.size.width;
    CGFloat widthH = self.frame.size.width / 2.0f;
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(widthH - 48, 17, 96, 64)];
    logoView.image = [HMResources image:@"logo" type:@"png"];
    logoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UIImageView *textFieldsView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, width - 20, 80)];
    textFieldsView.image = [[HMResources image:@"text-fields" type:@"png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    textFieldsView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    UITextField *usernameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 105, width - 40, 30)];
    usernameField.font = [UIFont fontWithName:@"Helvetica" size:14];
    usernameField.textColor = [UIColor whiteColor];
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameField.placeholder = NSLocalizedString(@"UsernamePlaceholderText", @"Username");
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, 145, width - 40, 30)];
    passwordField.font = [UIFont fontWithName:@"Helvetica" size:14];
    passwordField.textColor = [UIColor whiteColor];
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.placeholder = NSLocalizedString(@"PasswordPlaceholderText", @"Password");
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    UIButton *signinButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 192, 81, 41)];
    signinButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    signinButton.titleLabel.textColor = [UIColor whiteColor];
    signinButton.titleLabel.shadowColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
    signinButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
    signinButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [signinButton setTitle:NSLocalizedString(@"Sign In", @"Sign In") forState:UIControlStateNormal];
    [signinButton setBackgroundImage:[HMResources image:@"button" type:@"png"] forState:UIControlStateNormal];
    
    UILabel *forgotLabel = [[UILabel alloc] initWithFrame:CGRectMake(99, 202, width - 109, 21)];
    forgotLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    forgotLabel.textColor = [UIColor whiteColor];
    forgotLabel.backgroundColor = [UIColor clearColor];
    forgotLabel.shadowColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
    forgotLabel.shadowOffset = CGSizeMake(1, 1);
    forgotLabel.text = NSLocalizedString(@"Forgot your password ?", @"Forgot your password ?");
    forgotLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    UILabel *copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 527, width - 47, 21)];
    copyrightLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    copyrightLabel.textColor = [UIColor whiteColor];
    copyrightLabel.backgroundColor = [UIColor clearColor];
    copyrightLabel.shadowColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
    copyrightLabel.shadowOffset = CGSizeMake(1, 1);
    copyrightLabel.text = @"Copyright Hive Solutions 2008-2012";
    copyrightLabel.textAlignment = NSTextAlignmentCenter ;
    copyrightLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

    [self addSubview:logoView];
    [self addSubview:textFieldsView];
    [self addSubview:usernameField];
    [self addSubview:passwordField];
    [self addSubview:signinButton];
    [self addSubview:forgotLabel];
    [self addSubview:copyrightLabel];
}

@end
