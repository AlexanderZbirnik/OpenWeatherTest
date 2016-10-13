//
//  CitiesContainerView.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 12.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "CitiesContainerView.h"

@implementation CitiesContainerView

- (void) animatedAppearance {
    
    self.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0f;
    }];
}

- (void) animatedDisappearance {
    
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0.f;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
}



@end
