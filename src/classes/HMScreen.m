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

#import "HMScreen.h"

@implementation HMScreen

+ (UIWindow *)keyWindow {
    UIWindow *fallback = nil;
    for(UIScene *scene in [[UIApplication sharedApplication] connectedScenes]) {
        if(![scene isKindOfClass:UIWindowScene.class]) { continue; }
        UIWindowScene *windowScene = (UIWindowScene *) scene;
        for(UIWindow *window in windowScene.windows) {
            if(window.isKeyWindow && scene.activationState == UISceneActivationStateForegroundActive) {
                return window;
            }
            if(fallback == nil) { fallback = window; }
        }
    }
    return fallback;
}

+ (UIEdgeInsets)safeAreaInsets {
    UIWindow *window = [HMScreen keyWindow];
    if(window == nil) { return UIEdgeInsetsZero; }
    return window.safeAreaInsets;
}

+ (CGFloat)getTopMargin {
    // the margins are relative to the legacy layout, which already
    // reserves 20pt for the status bar, and are calibrated so that the
    // iPhone X (44pt safe area) keeps its historical 16pt value
    CGFloat top = [HMScreen safeAreaInsets].top - 28.0;
    return top > 0.0 ? top : 0.0;
}

+ (CGFloat)getBottomMargin {
    // calibrated so that devices with a home indicator (34pt safe
    // area) keep their historical 16pt value
    CGFloat bottom = [HMScreen safeAreaInsets].bottom - 18.0;
    return bottom > 0.0 ? bottom : 0.0;
}

+ (CGFloat)getLeftMargin {
    return [HMScreen safeAreaInsets].left;
}

+ (CGFloat)getRightMargin {
    return [HMScreen safeAreaInsets].right;
}

@end
