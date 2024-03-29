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

#import "StressViewController.h"

@implementation StressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.navigationItem.title = @"Stress";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateRequest];
}

- (void)updateRequest {
    self.scrollView.contentSize = CGSizeMake(9000, 9000);
    for(int index = 0; index < 1000; index++) {
        int _index = index % 24;
        NSString *url = [NSString stringWithFormat:@"https://sandbox.platforme.com/compose?model=elvis&p=buckles:metal_tp:black&p=lining:calf_lining_tp:beige&p=sole:leather_tp:black&p=rhinestones:rhinestones_tp:mix_color1&p=upper:nappa_tp:black&p=shadow:default:default&size=300&frame=%d", _index];
        self.imageView.imageWithURLString = url;
    }
}

@end
