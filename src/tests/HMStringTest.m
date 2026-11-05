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

#import "HMStringTest.h"

@implementation HMStringTest

- (void)testCapitalized {
    NSString *result = [HMString capitalizedString:@"joao"];
    XCTAssert([result isEqualToString:@"Joao"], "result is invalid");

    result = [HMString capitalizedString:@"joao magalhaes"];
    XCTAssert([result isEqualToString:@"Joao magalhaes"], "result is invalid");

    result = [HMString capitalizedString:@"joão magalhães"];
    XCTAssert([result isEqualToString:@"João magalhães"], "result is invalid");

    result = [HMString capitalizedString:@""];
    XCTAssert([result isEqualToString:@""], "result is invalid");

    result = [HMString capitalizedString:nil];
    XCTAssertNil(result, "result is invalid");
}

- (void)testQuoteComponent {
    NSString *result = [HMString quoteComponent:@"p&ss=w+rd#1?/"];
    XCTAssert([result isEqualToString:@"p%26ss%3Dw%2Brd%231%3F%2F"], "result is invalid");

    result = [HMString quoteComponent:@"joão magalhães"];
    XCTAssert([result isEqualToString:@"jo%C3%A3o%20magalh%C3%A3es"], "result is invalid");

    result = [HMString quoteComponent:nil];
    XCTAssert([result isEqualToString:@""], "result is invalid");

    NSString *url = [@"https://hive.pt/login.json?password=" stringByAppendingString:[HMString quoteComponent:@"a&b=c+d"]];
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    XCTAssert([components.queryItems.firstObject.value isEqualToString:@"a&b=c+d"], "result is invalid");
}

@end
