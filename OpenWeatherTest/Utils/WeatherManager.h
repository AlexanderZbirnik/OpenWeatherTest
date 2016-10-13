//
//  WeatherManager.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

+ (instancetype)sharedInstance;

- (void) weatherWithCityName: (NSString *) cityName success:(void(^) (NSDictionary *dict)) success onFailure: (void(^) (NSError *error)) failure;

- (void) weatherWithLatitude: (double) latitude andLongitude: (double) longitude success:(void(^) (NSDictionary *dict)) success onFailure: (void(^) (NSError *error)) failure;

@end
