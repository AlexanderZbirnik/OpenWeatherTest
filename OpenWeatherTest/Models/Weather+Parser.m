//
//  Weather+Parser.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "Weather+Parser.h"

@implementation Weather (Parser)

-(void) parseOpenWeatherJSONDict: (NSDictionary *) dict {
    
    self.city = [dict objectForKey:@"name"];
    
    NSDictionary *sysDict = [dict objectForKey:@"sys"];
    
    self.countryCode = [sysDict objectForKey:@"country"];
    
    NSDictionary *coordDict = [dict objectForKey:@"coord"];
    
    self.latitude = [coordDict objectForKey:@"lat"];
    self.longitude = [coordDict objectForKey:@"lon"];
    
    NSDictionary *mainDict = [dict objectForKey:@"main"];
    
    self.temperature =
    [NSString stringWithFormat:@"%.1f °C", [[mainDict objectForKey:@"temp"] floatValue]];
    
    self.humidity =
    [NSString stringWithFormat:@"%@ %%", [mainDict objectForKey:@"humidity"]];
    
    NSDictionary *windDict = [dict objectForKey:@"wind"];
    
    self.windSpeed =
    [NSString stringWithFormat:@"%.1f m/s", [[windDict objectForKey:@"speed"] floatValue]];
    
}

@end
