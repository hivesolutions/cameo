// Hive Cameo Framework
// Copyright (C) 2008-2017 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "ImageViewController.h"

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.navigationItem.title = @"Images";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // retrieves the pattern image to be used and sets it in
    // the current view (should be able to change the background)
    UIImage *patternImage = [HMResources imageNamed:@"main-background-black.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];

    // creates the various layout elements that are part of the
    // current panel and adds them to the current view
    [self createRound];
    [self createAnimation];
    [self createLogout];
}

- (void)createRound {
    // retrieves the width of the current view's frame
    // and divides it
    CGFloat width = self.view.frame.size.width;
    CGFloat widthH = width / 2;

    // creates a new round image with the current logo and presents it
    // centered in the screeen, this demonstrates the round
    UIImage *roundImage = [[UIImage imageNamed:@"logo-square.png"] roundWithRadius:8];
    UIImageView *roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(widthH - roundImage.size.width / 2, 80, roundImage.size.width, roundImage.size.height)];
    roundImageView.image = roundImage;
    roundImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:roundImageView];
}

- (void)createAnimation {
    // retrieves the width of the current view's frame
    // and divides it
    CGFloat width = self.view.frame.size.width;
    CGFloat widthH = width / 2;

    // retrieves the sprite image and then uses it to create the animation
    // and then adds it to the current view
    UIImage *sprite = [UIImage imageNamed:@"logo-sprite.png"];
    UIImageView *animation = [UIImage animationFromSprite:sprite width:96 height:96];
    animation.frame = CGRectMake(widthH - 48, 200, 96, 96);
    animation.animationDuration = 2.0f;
    animation.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:animation];
    [animation startAnimating];
}

- (void)createLogout {
    // retrieves the width of the current view's frame
    // and divides it
    CGFloat width = self.view.frame.size.width;
    CGFloat widthH = width / 2;

    // creates the logout button initializing the click
    // handlers and setting the proper image in it
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(widthH - 48, 320, 96, 48);
    logoutButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [logoutButton addTarget:self
                     action:@selector(logout)
           forControlEvents:UIControlEventTouchUpInside];
    UIImage *logoutButtonImage = [UIImage imageNamed:@"logout-button.png"];
    [logoutButton setImage:logoutButtonImage forState:UIControlStateNormal];
    [self.view addSubview:logoutButton];
}

- (void)logout {
    // creates a new proxy request object and immediatly
    // triggers the show of the login page (forced)
    HMProxyRequest *_proxyRequest = [[HMProxyRequest alloc] initWithPath:self path:nil];
    [_proxyRequest showLogin];
}

@end
