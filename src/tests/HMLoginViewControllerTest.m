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

#import "HMLoginViewControllerTest.h"

@implementation HMLoginViewControllerTest

- (void)setUp {
    [super setUp];
    self.preferences = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
}

- (void)tearDown {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    for(NSString *key in @[@"username", @"objectId", @"sessionId"]) {
        [preferences setValue:self.preferences[key] forKey:key];
    }
    [super tearDown];
}

- (void)testLoginWithSession {
    HMLoginViewController *controller = [[HMLoginViewController alloc] init];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // finishes the login with a session obtained some other way, the session
    // id, the username and the object id must be stored in the preferences
    [controller loginWithSession:@"session-xyz" username:@"demo" objectId:@"42"];
    XCTAssert([[preferences valueForKey:@"sessionId"] isEqualToString:@"session-xyz"], "session must be stored");
    XCTAssert([[preferences valueForKey:@"username"] isEqualToString:@"demo"], "username must be stored");
    XCTAssert([[preferences valueForKey:@"objectId"] isEqualToString:@"42"], "object id must be stored");
}

- (void)testDidReceiveData {
    HMLoginViewController *controller = [[HMLoginViewController alloc] init];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // the authentication structure is stored as the session, the username
    // and the object id (the login finishes with the received session)
    [controller didReceiveData:@{@"session_id" : @"session-abc", @"username" : @"user", @"object_id" : @"13"}];
    XCTAssert([[preferences valueForKey:@"sessionId"] isEqualToString:@"session-abc"], "session must be stored");
    XCTAssert([[preferences valueForKey:@"username"] isEqualToString:@"user"], "username must be stored");
    XCTAssert([[preferences valueForKey:@"objectId"] isEqualToString:@"13"], "object id must be stored");
}

@end
