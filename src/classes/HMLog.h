// Hive Cameo Framework
// Copyright (C) 2008-2014 Hive Solutions Lda.
//
// This file is part of Hive Cameo Framework.
//
// Hive Cameo Framework is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Cameo Framework is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Cameo Framework. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#define HM_CRITICAL 5
#define HM_ERROR 4
#define HM_WARNING 3
#define HM_INFO 2
#define HM_DEBUG 1

@interface HMLog : NSObject

+ (void)critical:(NSString *)value, ...;
+ (void)error:(NSString *)value, ...;
+ (void)warning:(NSString *)value, ...;
+ (void)info:(NSString *)value, ...;
+ (void)debug:(NSString *)value, ...;
+ (void)emit:(int)level value:(NSString *)value;

@end
