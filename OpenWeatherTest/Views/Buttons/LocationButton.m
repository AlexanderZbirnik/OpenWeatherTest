//
//  LocationButton.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "LocationButton.h"

@interface LocationButton()

@property (assign, nonatomic) CGFloat borderWidth;

@end

@implementation LocationButton

- (void) setBorderWidth:(CGFloat)borderWidth {
    
    _borderWidth = borderWidth;
}

- (void) setEnabled:(BOOL)enabled {
    
    UIColor *color;
    
    if (enabled) {
        
        color = self.tintColor;
        
    } else {
        
        color = [UIColor lightGrayColor];
    }
    
    self.layer.borderColor  = color.CGColor;
    self.imageView.tintColor = color;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    self.layer.borderColor  = self.tintColor.CGColor;
    self.layer.borderWidth  = self.borderWidth;
    
    self.imageView.image =
    [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.imageView.tintColor = self.tintColor;

}

@end
