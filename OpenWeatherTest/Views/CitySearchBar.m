//
//  CitySearchBar.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 12.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "CitySearchBar.h"

@implementation CitySearchBar

- (void)layoutSubviews {
    [super layoutSubviews];
        
    self.layer.cornerRadius = 5.f;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = self.tintColor.CGColor;
    self.layer.masksToBounds = YES;
}

@end
