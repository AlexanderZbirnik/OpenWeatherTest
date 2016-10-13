//
//  Weather+Parser.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "Weather.h"

@interface Weather (Parser)

-(void) parseOpenWeatherJSONDict: (NSDictionary *) dict;

@end
