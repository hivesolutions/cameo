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

#import "HMLoginView.h"

@implementation HMLoginView

- (id)init {
    self = [super init];
    if(self) {
        [self doLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self doLayout];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self doLayout];
    }
    return self;
}

- (void)doLayout {
    self.contentMode = UIViewContentModeCenter;
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // retrieves the pattern image to be used and sets it in
    // the current view (should be able to change the background)
    UIImage *patternImage = [HMResources image:@"main-background-dark" type:@"png"];;
    self.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    /*
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    backgroundView.image = [[UIImage imageNamed:@"dashboard-background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    UIImageView *directionView = [[UIImageView alloc] initWithFrame:CGRectMake(128, 8, 64, 64)];
    directionView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh-gray.png"] forState:UIControlStateNormal];
    refreshButton.frame = CGRectMake(276, 39, 36, 36);
    refreshButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [refreshButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 79, 170, 21)];
    storeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    storeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    storeLabel.backgroundColor = [UIColor clearColor];
    storeLabel.textColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1.0];
    storeLabel.shadowColor = [UIColor whiteColor];
    storeLabel.shadowOffset = CGSizeMake(1, 1);
    
    UILabel *todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 96, 170, 21)];
    todayLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    todayLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    todayLabel.backgroundColor = [UIColor clearColor];
    todayLabel.text = NSLocalizedString(@"TODAY'S SALES", @"TODAY'S SALES");
    todayLabel.textColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1.0];
    todayLabel.shadowColor = [UIColor whiteColor];
    todayLabel.shadowOffset = CGSizeMake(1, 1);
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 93, 119, 21)];
    amountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    amountLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    amountLabel.backgroundColor = [UIColor clearColor];
    amountLabel.textColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1.0];
    amountLabel.shadowColor = [UIColor whiteColor];
    amountLabel.shadowOffset = CGSizeMake(1, 1);
    amountLabel.textAlignment = UITextAlignmentRight;
    
    UILabel *currencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(281, 96, 27, 21)];
    currencyLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    currencyLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    currencyLabel.backgroundColor = [UIColor clearColor];
    currencyLabel.text = NSLocalizedString(@"EUR", @"EUR");
    currencyLabel.textColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1.0];
    currencyLabel.shadowColor = [UIColor whiteColor];
    currencyLabel.shadowOffset = CGSizeMake(1, 1);
    
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.autoresizesSubviews = YES;
    
    [self addSubview:backgroundView];
    [self addSubview:directionView];
    [self addSubview:refreshButton];
    [self addSubview:storeLabel];
    [self addSubview:todayLabel];
    [self addSubview:amountLabel];
    [self addSubview:currencyLabel];
    
    int yOffset = 143;
    
    NSMutableArray *days = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < 5; index++) {
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, yOffset, 170, 23)];
        dayLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        dayLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.textColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1.0];
        dayLabel.shadowColor = [UIColor whiteColor];
        dayLabel.shadowOffset = CGSizeMake(1, 1);
        
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, yOffset, 119, 23)];
        amountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        amountLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        amountLabel.backgroundColor = [UIColor clearColor];
        amountLabel.textColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1.0];
        amountLabel.shadowColor = [UIColor whiteColor];
        amountLabel.shadowOffset = CGSizeMake(1, 1);
        amountLabel.textAlignment = UITextAlignmentRight;
        
        UILabel *currencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(281, yOffset + 4, 27, 21)];
        currencyLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        currencyLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        currencyLabel.backgroundColor = [UIColor clearColor];
        currencyLabel.text = NSLocalizedString(@"EUR", @"EUR");
        currencyLabel.textColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1.0];
        currencyLabel.shadowColor = [UIColor whiteColor];
        currencyLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self addSubview:dayLabel];
        [self addSubview:amountLabel];
        [self addSubview:currencyLabel];
        
        NSArray *day = [[NSArray alloc] initWithObjects:dayLabel, amountLabel, currencyLabel, nil];
        [days addObject:day];
        
        yOffset += 56;
    }
    
    self.directionView = directionView;
    self.storeLabel = storeLabel;
    self.amountLabel = amountLabel;
    self.curencyLabel = currencyLabel;
    self.days = days;*/
}

@end
