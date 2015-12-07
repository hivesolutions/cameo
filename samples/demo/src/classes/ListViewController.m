// Hive Cameo Framework
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "ListViewController.h"

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.navigationItem.title = @"Cameo";
        self.items = @[
            @{
                @"name" : @"Images",
                @"view" : [ImageViewController class],
            },
            @{
                @"name" : @"Blend",
                @"view" : [BlendViewController class],
            },
            @{
                @"name" : @"Request",
                @"view" : [RequestViewController class],
            },
            @{
                @"name" : @"API",
                @"view" : [ApiViewController class],
            },
            @{
                @"name" : @"Stress",
                @"view" : [StressViewController class],
            },
            @{
                @"name" : @"Swift",
                @"view" : [SwiftViewController class],
            }
        ];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UItableViewCell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] init];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }

    cell.textLabel.text = self.items[indexPath.row][@"name"];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView respondsToSelector:@selector(setSeparatorInset:)]) tableView.separatorInset = UIEdgeInsetsZero;
    if([tableView respondsToSelector:@selector(setLayoutMargins:)]) tableView.layoutMargins = UIEdgeInsetsZero;
    if([cell respondsToSelector:@selector(setLayoutMargins:)]) cell.layoutMargins = UIEdgeInsetsZero;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class view = self.items[indexPath.row][@"view"];
    UIViewController *controller = [[view alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
