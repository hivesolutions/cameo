// Hive Cameo Framework
// Copyright (C) 2008-2012 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMLog.h"

NSString * const HMLevels[] = {
    @"DEBUG",
    @"INFO",
    @"WARNING",
    @"ERROR",
    @"CRITICAL"
};

@implementation HMLog

+ (void)critical:(NSString *)value {
    [HMLog emit:HM_CRITICAL value:value];
}

+ (void)error:(NSString *)value {
    [HMLog emit:HM_ERROR value:value];
}

+ (void)warning:(NSString *)value {
    [HMLog emit:HM_ERROR value:value];
}

+ (void)info:(NSString *)value {
    [HMLog emit:HM_INFO value:value];
}

+ (void)debug:(NSString *)value {
    [HMLog emit:HM_DEBUG value:value];
}

+ (void)emit:(int)level value:(NSString *)value {
    NSString *levelS = HMLevels[level - 1];
    NSString *logMessage = [NSString stringWithFormat:@"[%@] - %@", levelS, value];
    NSLog(@"%@", logMessage);
}

@end
