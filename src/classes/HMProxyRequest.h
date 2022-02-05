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

#import "Dependencies.h"

#import "HMRequest.h"
#import "HMLoginView.h"
#import "HMJSONSerializer.h"
#import "HMRequestDelegate.h"
#import "HMLoginViewController.h"
#import "HMProxyRequestDelegate.h"

/**
 Responsible for the coordination of the remote calls with the proper visual changes (loading mask settings).
 */
@interface HMProxyRequest : NSObject<HMRequestDelegate> {
}

@property (nonatomic, weak) NSObject<HMProxyRequestDelegate> *delegate;
@property (nonatomic) UIViewController *controller;
@property (nonatomic) NSString *baseUrl;
@property (nonatomic) NSString *sessionId;
@property (nonatomic) NSString *path;
@property (nonatomic) NSString *method;
@property (nonatomic) NSArray *parameters;
@property (nonatomic) NSObject<HMSerializer> *serializer;
@property (nonatomic) UIView *mask;
@property (nonatomic) UIActivityIndicatorView *maskIndicator;
@property (nonatomic) HMRequest *request;
@property (nonatomic) NSString *loginPath;
@property (nonatomic) bool loading;
@property (nonatomic) bool useSession;

- (id)initWithPath:(UIViewController *)controller path:(NSString *)path;
- (id)initWithPath:(UIViewController *)controller path:(NSString *)path loginPath:(NSString *)loginPath;
- (void)load;
- (void)showLogin;
+ (void)setLogo:(UIImage *)logo;

@end
