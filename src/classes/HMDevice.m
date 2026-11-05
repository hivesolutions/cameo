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

#import "HMDevice.h"

@implementation HMDevice

+ (BOOL)isPhone {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isTablet {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)isIPhoneX {
    if([HMDevice isPhone] == NO) {
        return NO;
    }
    // any phone with a home indicator (bottom safe area) belongs to the
    // "iPhone X" family (notch or Dynamic Island), not only the 812pt one
    for(UIScene *scene in [[UIApplication sharedApplication] connectedScenes]) {
        if(![scene isKindOfClass:UIWindowScene.class]) { continue; }
        for(UIWindow *window in ((UIWindowScene *) scene).windows) {
            return window.safeAreaInsets.bottom > 0.0;
        }
    }
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return MAX(screenSize.width, screenSize.height) >= 812;
}

@end
