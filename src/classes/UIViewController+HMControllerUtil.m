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

#import "UIViewController+HMControllerUtil.h"

@implementation UIViewController(HMControllerUtil)

- (void)setNavigationTitle:(NSString *)title {
    // checks if the view associated with the current view
    // controller is already visible in such case changes the
    // navigation bar item directly, otherwise uses the "traditional"
    // title access method for the change
    if(self.isViewLoaded && self.view.window) {
        self.navigationController.navigationBar.topItem.title = title;
    } else {
        self.title = title;
    }
}

@end
