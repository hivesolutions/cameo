// Hive Cameo Framework
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "BlendViewController.h"

@implementation BlendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.navigationItem.title = @"Blend";
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
    [self updateBlend];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateBlend {
    for (UIView *subView in self.mainView.subviews) {
        [subView removeFromSuperview];
    }
    if(self.switchView.on) {
        [self createBlendFast];
    } else {
        [self createBlend];
    }
}

- (void)createBlend {
    // retrieves the reference to the various image to blend and
    // then runs the belding with the proper algorithm
    UIImage *sole = [UIImage imageNamed:@"shoe-sole.png"];
    UIImage *back = [UIImage imageNamed:@"shoe-back.png"];
    UIImage *result = [sole blendImage:back algorithm:@"disjoint_under"];
    UIImage *front = [UIImage imageNamed:@"shoe-front.png"];
    result = [result blendImage:front algorithm:@"disjoint_under"];
    UIImage *shoelace = [UIImage imageNamed:@"shoe-shoelace.png"];
    result = [result blendImage:shoelace algorithm:@"disjoint_under"];

    // creates the blend image view to be used and runs the resize
    // mask for it in order to display it properly
    UIImageView *blend = [[UIImageView alloc] init];
    blend.backgroundColor = [UIColor clearColor];
    blend.image = result;
    blend.contentMode = UIViewContentModeScaleAspectFit;
    blend.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    blend.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.mainView addSubview:blend];
}

- (void)createBlendFast {
    // retrieves the reference to the various image to blend and
    // then runs the belding with the proper algorithm
    UIImage *sole = [UIImage imageNamed:@"shoe-sole.png"];
    UIImage *back = [UIImage imageNamed:@"shoe-back.png"];
    UIImage *result = [sole blendImageFast:back algorithm:kCGBlendModeLighten];
    UIImage *front = [UIImage imageNamed:@"shoe-front.png"];
    result = [result blendImageFast:front algorithm:kCGBlendModeLighten];
    UIImage *shoelace = [UIImage imageNamed:@"shoe-shoelace.png"];
    result = [result blendImageFast:shoelace algorithm:kCGBlendModeLighten];

    // creates the blend image view to be used and runs the resize
    // mask for it in order to display it properly
    UIImageView *blend = [[UIImageView alloc] init];
    blend.backgroundColor = [UIColor clearColor];
    blend.image = result;
    blend.contentMode = UIViewContentModeScaleAspectFit;
    blend.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    blend.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.mainView addSubview:blend];
}

- (IBAction)switchChanged:(id)sender {
    [self updateBlend];
}

@end
