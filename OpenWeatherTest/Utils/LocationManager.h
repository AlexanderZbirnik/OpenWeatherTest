//
//  LocationManager.h
//  GoogleMapsTest
//
//  Created by Alex Zbirnik on 22.09.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const LocationManagerCoordinateUserInfoKey        = @"LocationManagerCoordinateUserInfoKey";
static NSString * const LocationManagerUpdateLocationNotification   = @"LocationManagerUpdateLocationNotification";

@interface LocationManager : NSObject

+ (instancetype)sharedInstance;

- (void) updateLocation;

@end
