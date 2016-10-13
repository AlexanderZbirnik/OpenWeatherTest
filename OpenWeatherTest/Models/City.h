//
//  City.h
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 12.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;

@end
