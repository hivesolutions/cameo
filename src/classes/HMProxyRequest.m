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

#import "HMProxyRequest.h"

@implementation HMProxyRequest

static UIImage *_logo = nil;

- (id)init {
    self = [super init];
    if(self) {
        self.loading = NO;
        self.useSession = YES;

        self.controller = nil;
        self.path = nil;
        self.method = @"GET";
        self.loginPath = @"login.json";
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (id)initWithPath:(UIViewController *)controller path:(NSString *)path {
    self = [super init];
    if(self) {
        self.loading = NO;
        self.useSession = YES;

        self.controller = controller;
        self.path = path;
        self.method = @"GET";
        self.loginPath = @"login.json";
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (id)initWithPath:(UIViewController *)controller path:(NSString *)path loginPath:(NSString *)loginPath {
    self = [super init];
    if(self) {
        self.loading = NO;
        self.useSession = YES;

        self.controller = controller;
        self.path = path;
        self.method = @"GET";
        self.loginPath = loginPath;
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (void)load {
    // tries to retrieve the session id from the current preferences
    // and in case it fails shows the login (default behavior)
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [preferences valueForKey:@"sessionId"];
    sessionId = self.sessionId ? self.sessionId : sessionId;
    if(!sessionId && self.useSession == YES) { [self showLogin]; return; }

    // allocates space for the array that will contain the various
    // key value tuples with the request parameters
    NSMutableArray *parameters;

    // retrieves the value for the base url from the preferences and
    // uses it together with the path value to construct the url string
    NSString *baseUrl = [preferences valueForKey:@"baseUrl"];
    baseUrl = self.baseUrl ? self.baseUrl : baseUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, self.path];

    // in case there are already parameters defined in the structure
    // they should be used and the parameters structure extended otherwise
    // an empty array is used instead, then adds the session id value into
    // the (mutable) parameters structure
    if(self.parameters) { parameters = [NSMutableArray arrayWithArray:self.parameters]; }
    else { parameters = [NSMutableArray array]; }
    if(self.useSession == YES) {
        [parameters addObject:[NSArray arrayWithObjects:@"session_id", sessionId, nil]];
    }

    // creates a request object and sets the currently created
    // parameters structure in it together with the setting of the
    // delegate reference and then triggers the loading of it
    self.request = [[HMRequest alloc] initWithUrlString:urlString];
    self.request.method = self.method;
    self.request.parameters = parameters;
    self.request.serializer = self.serializer;
    self.request.delegate = self;
    [self.request load];
}

- (void)showLogin {
    // presents the login view controller in a modal fashion
    // this should slide the view from bottom to the top
    HMLoginViewController *loginViewController = [[HMLoginViewController alloc] init];
    loginViewController.loginPath = self.loginPath;
    loginViewController.view = [[HMLoginView alloc] init];
    HMLoginView *loginView = (HMLoginView *) loginViewController.view;
    loginView.logo = _logo;
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UIViewController *controller = self.controller ? self.controller : rootViewController;
    [controller presentViewController:loginViewController animated:YES completion:nil];
}

- (void)showLightMask {
    // in case the mask view in case it's not currently
    // set in the instance (lazy create)
    if(self.mask == nil) { [self createMask]; }

    // shows the (now transparent) mask so that the user
    // is not able to click in the screen (avoids double
    // request, and problems)
    self.mask.hidden = NO;
}

- (void)showMask {
    // in case the current proxy structure is not
    // commnicating with the server anymore no need
    // to show the mask (finished)
    if(self.loading == NO) { return; }

    // in case the mask view in case it's not currently
    // set in the instance (lazy create)
    if(self.mask == nil) { [self createMask]; }

    // shows the mask view (display) and starts the animation
    // in the indicator object, note that the color of the
    // mask is changed to black (visible)
    [UIView beginAnimations:@"fadeIn" context: nil];
    [UIView setAnimationDuration:0.35];
    self.mask.backgroundColor = [UIColor blackColor];
    self.mask.hidden = NO;
    [UIView commitAnimations];
    [self.maskIndicator startAnimating];
}

- (void)hideMask {
    // in case the mask view in case it's not currently
    // set in the instance (lazy create)
    if(self.mask == nil) { [self createMask]; }

    // creates the fade out animation for the mask view
    // so that it hides using an animation
    [UIView beginAnimations:@"fadeOut" context: nil];
    [UIView setAnimationDuration:0.25];
    self.mask.alpha = 0.0;
    [UIView commitAnimations];

    // stops animating the mask (activity) indicator
    // this should stop the animation
    [self.maskIndicator stopAnimating];
}

- (void)createMask {
    // in case the view is already
    // created must return immediately
    if(self.mask != nil) { return; }

    // retrieves the view associated with the current controller
    // as the target view for the mask (activity indicator)
    UIView *view = self.controller.view;

    // creates the mask view to be used for the purpose of indicating
    // a loading activity
    CGRect maskFrame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    UIView *mask = [[UIView alloc] initWithFrame:maskFrame];
    mask.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mask.backgroundColor = [UIColor clearColor];
    mask.alpha = 0.35;
    mask.hidden = YES;

    // creates the mask (activity) indicator indicator to be used as
    // an animation
    CGRect maskIndicatorFrame = CGRectMake(view.bounds.size.width / 2 - 12, view.bounds.size.height / 2 - 12, 24, 24);
    UIActivityIndicatorView *maskIndicator = [[UIActivityIndicatorView alloc] initWithFrame:maskIndicatorFrame];
    maskIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    maskIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    maskIndicator.hidden = YES;

    // creates the activity structure
    [view addSubview:mask];
    [view addSubview:maskIndicator];

    // sets the mask attribute in the current instance
    // to be used latter for display
    self.mask = mask;
    self.maskIndicator = maskIndicator;
}

- (void)didSend {
    // sets the loading flag indicating that the current
    // proxy is communicating with the server side
    self.loading = YES;

    // shows the light mask (transparent mask) so that the
    // user is forbidden from touching other items
    [self showLightMask];

    // schedules the the showing of the mask for a bit latter
    // so that it's only displayed for long loadings
    [NSTimer scheduledTimerWithTimeInterval:1.25
                                     target:self
                                   selector:@selector(showMask)
                                   userInfo:nil
                                    repeats:NO];

    if(self.delegate) {
        bool responds = [self.delegate respondsToSelector:@selector(didSend)];
        if(responds) { [self.delegate didSend]; }
    }
}

- (void)didReceive {
    // unsets the loading flag indicating that the current
    // proxy is not communicating with the server side
    self.loading = NO;

    // hides the mask view to indicate the user about the
    // end of the loading process
    [self hideMask];

    if(self.delegate) {
        bool responds = [self.delegate respondsToSelector:@selector(didReceive)];
        if(responds) { [self.delegate didReceive]; }
    }
}

- (void)didReceiveData:(id)data {
    NSDictionary *exception = nil;
    BOOL isDictionary = [data isKindOfClass:NSDictionary.class];
    if(isDictionary) { exception = [data valueForKey:@"exception"]; }
    if(exception && self.useSession == YES) { [self showLogin]; return; }

    if(self.delegate) { [self.delegate didReceiveData:data]; }
}

- (void)didReceiveError:(NSError *)error {
    // retrieves the localized error description, this is considered
    // to be the message to be presented
    NSString *message = [error localizedDescription];
    message = [HMString capitalizedString:message];
    message = [HMResources localizedString:message withDefault:message];

    // creates the alert window that will be used to display the error
    // associated with the current authentication failure and then shows
    // it in a modal fashion, then returns immediately to the caller method
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HMResources localizedString:@"ConnectionError" withDefault:@"Connection Error"]
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:[HMResources localizedString:@"Confirm" withDefault:@"Confirm"]
                                          otherButtonTitles:nil];
    [alert show];

    if(self.delegate) { [self.delegate didReceiveError:error]; }
}

+ (void)setLogo:(UIImage *)logo {
    _logo = logo;
}

@end
