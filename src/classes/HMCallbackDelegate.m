// Hive Cameo Framework
// Copyright (C) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMCallbackDelegate.h"

@implementation HMCallbackDelegate

- (id)initWithCallback:(RequestBlock)callback {
    self = [super init];
    if(self) {
        _callback = callback;
    }
    return self;
}

- (id)initWithCallback:(RequestBlock)callback owner:(NSObject<HMCleanup> *)owner {
    self = [super init];
    if(self) {
        _callback = callback;
        self.owner = owner;
    }
    return self;
}

- (void)didReceiveData:(id)data {
    if(_callback) { _callback(data, nil); }
    if(self.owner) { [self.owner cleanup:self]; }
}

- (void)didReceiveError:(NSError *)error {
    if(_callback) { _callback(nil, error); }
    if(self.owner) { [self.owner cleanup:self]; }
}

@end
