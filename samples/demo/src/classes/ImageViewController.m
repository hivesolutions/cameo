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

#import "ImageViewController.h"

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // retrieves the pattern image to be used and sets it in
    // the current view (should be able to change the background)
    UIImage *patternImage = [HMResources imageNamed:@"main-background-black.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    [self createRound];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    HMProxyRequest *_proxyRequest = [[HMProxyRequest alloc] initWithPath:self path:@"cameras.json"];
    // @TODO: structure this in the correct manner to allow "dummy login"
    // _proxyRequest.delegate = self;
    //_proxyRequest.parameters = [NSArray arrayWithObjects: nil];
    //[_proxyRequest load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createRound {
    // retrieves the width of the current view's frame
    // and divides it 
    CGFloat width = self.view.frame.size.width;
    CGFloat widthH = width / 2;
    
    // creates a new round image with the current logo and presents it
    // centered in the screeen
    UIImage *roundImage = [[UIImage imageNamed:@"logo-square.png"] roundWithRadius:8];
    UIImageView *roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(widthH - roundImage.size.width / 2, 80, roundImage.size.width, roundImage.size.height)];
    roundImageView.image = roundImage;
    roundImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:roundImageView];
    
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

@end
