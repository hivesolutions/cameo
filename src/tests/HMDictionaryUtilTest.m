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

#import "HMDictionaryUtilTest.h"

@implementation HMDictionaryUtilTest

- (void)testMerged {
    NSDictionary *original = @{@"a" : @"first"};
    NSDictionary *other = @{@"b" : @"second"};
    NSDictionary *result = [original merged:other];

    XCTAssertEqual(result.count, 2, "size must be two");
    XCTAssert([result[@"a"] isEqualToString:@"first"], "first value is invalid");
    XCTAssert([result[@"b"] isEqualToString:@"second"], "second value is invalid");

    original = @{@"a" : @"first"};
    other = @{@"a" : @"second"};
    result = [original merged:other];

    XCTAssertEqual(result.count, 1, "size must be one");
    XCTAssert([result[@"a"] isEqualToString:@"second"], "first value is invalid");
}

@end
