//
//  WeatherViewController.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 10.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeatherViewControllerDelegate;

@interface WeatherViewController : UIViewController

@property (weak, nonatomic) id < WeatherViewControllerDelegate > delegate;

@end

@protocol WeatherViewControllerDelegate

@required

- (void) weatherViewController: (WeatherViewController *) weatherViewController textDidChange:(NSString *)searchText;

@end
