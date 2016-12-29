// Hive Cameo Framework
// Copyright (C) 2008-2017 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#define HM_CRITICAL 5
#define HM_ERROR 4
#define HM_WARNING 3
#define HM_INFO 2
#define HM_DEBUG 1

@interface HMLog : NSObject {
}

+ (void)critical:(NSString *)value, ...;
+ (void)error:(NSString *)value, ...;
+ (void)warning:(NSString *)value, ...;
+ (void)info:(NSString *)value, ...;
+ (void)debug:(NSString *)value, ...;
+ (void)emit:(int)level value:(NSString *)value;

@end
