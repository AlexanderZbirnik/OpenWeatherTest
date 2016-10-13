//
//  DarkView.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 12.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "DarkView.h"

@implementation DarkView

- (void) animatedAppearance {
    
    self.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0.5f;
    }];
}

- (void) animatedDisappearance {
    
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0.f;
    }];
}

@end
