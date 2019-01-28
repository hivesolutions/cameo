// Hive Cameo Framework
// Copyright (C) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMJSONSerializerTest.h"

@implementation HMJSONSerializerTest

- (void)testMap {
    XCTestExpectation *firstExpectation = [self expectationWithDescription:@"first"];
    HMJSONSerializer *serializer = [HMJSONSerializer getForClass:HMDataDevice.class];
    [HMProxy.singleton get:@"http://httpbin.org/ip"
                parameters:nil
                useSession:NO
                serializer:serializer
                  callback:^(HMDataDevice *result, NSError *error) {
                      XCTAssertNotNil(result.origin);
                      [firstExpectation fulfill];
                  }];

    [self waitForExpectationsWithTimeout:15 handler:^(NSError *error) {}];
}

@end
