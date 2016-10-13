//
//  LocationManager.m
//  GoogleMapsTest
//
//  Created by Alex Zbirnik on 22.09.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Macros.h"

@interface LocationManager() < CLLocationManagerDelegate >

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationManager

+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter  = kCLLocationAccuracyKilometer;
        self.locationManager.pausesLocationUpdatesAutomatically = false;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
            
            self.locationManager.allowsBackgroundLocationUpdates = true;
            
        } else {
            
            [self.locationManager requestWhenInUseAuthorization]; // for ios8
        }
        
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    return self;
}

- (void) updateLocation {
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocationCoordinate2D coordinate = [[locations lastObject] coordinate];
        
    NSValue *coordinateValue = [NSValue value:&coordinate withObjCType:@encode(CLLocationCoordinate2D)];
    NSDictionary *userInfo = @{LocationManagerCoordinateUserInfoKey : coordinateValue};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationManagerUpdateLocationNotification
                                                        object:nil
                                                      userInfo:userInfo];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"error: %@", [error localizedDescription]);
}

@end


















