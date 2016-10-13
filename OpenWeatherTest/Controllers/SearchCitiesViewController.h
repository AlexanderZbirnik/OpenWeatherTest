//
//  SearchCitiesViewController.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"

@protocol SearchCitiesViewControllerDelegate;

@interface SearchCitiesViewController : UIViewController < WeatherViewControllerDelegate >

@property (weak, nonatomic) id < SearchCitiesViewControllerDelegate > delegate;

@end

@protocol SearchCitiesViewControllerDelegate

@required

- (void) searchCitiesViewController: (SearchCitiesViewController *) searchCitiesViewController cityName: (NSString *) name address: (NSString *) address latitude: (double) latitude longitude: (double) longitude;

@end
