//
//  Weather.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject


@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *countryCode;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

@property (strong, nonatomic) NSString *temperature;
@property (strong, nonatomic) NSString *humidity;
@property (strong, nonatomic) NSString *windSpeed;

@end
