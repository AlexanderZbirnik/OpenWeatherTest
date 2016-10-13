//
//  City+Parser.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 12.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "City.h"
#import <GooglePlaces/GooglePlaces.h>

@interface City (Parser)

- (void) parseCityFromGMSPlace: (GMSPlace *) place;

@end
