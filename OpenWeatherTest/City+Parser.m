//
//  City+Parser.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 12.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "City+Parser.h"

@implementation City (Parser)

- (void) parseCityFromGMSPlace: (GMSPlace *) place {
    
    self.name = place.name;
    self.address = place.formattedAddress;
    self.latitude   = place.coordinate.latitude;
    self.longitude  = place.coordinate.longitude;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"City: %@, address: %@ coordinate: {%.4f, %.4f}",
            self.name, self.address, self.latitude, self.longitude];
}

@end
