//
//  WeatherManager.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "WeatherManager.h"
#import "AFNetworking.h"

// Base url
NSString * const baseUrlString = @"http://api.openweathermap.org/data/2.5/weather";

// Parameters
NSString * const APPID  = @"0677c870d0884aa320f05c963bdb5a70";
NSString * const metric = @"metric";

// Parameters keys
NSString * const cityNameKey    = @"q";
NSString * const appIdKey       = @"APPID";

NSString * const latitudeKey    = @"lat";
NSString * const longitudeKey   = @"lon";

NSString * const unitsMeticKey  = @"units";

@interface WeatherManager()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation WeatherManager

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
        
        self.manager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void) weatherWithCityName: (NSString *) cityName success:(void(^) (NSDictionary *dict)) success onFailure: (void(^) (NSError *error)) failure {
    
    NSDictionary *parameters =
    @{cityNameKey: cityName, unitsMeticKey: metric, appIdKey: APPID};
    
    [self.manager GET:baseUrlString
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  if(success) {
                      
                      success(responseObject);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  if(failure) {
                      
                      failure(error);
                  }
              }];
}

- (void) weatherWithLatitude: (double) latitude andLongitude: (double) longitude success:(void(^) (NSDictionary *dict)) success onFailure: (void(^) (NSError *error)) failure {
    
    NSDictionary *parameters =
    @{latitudeKey: @(latitude), longitudeKey: @(longitude), unitsMeticKey: metric, appIdKey: APPID};
    
    [self.manager GET:baseUrlString
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  if(success) {
                      
                      success(responseObject);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                  if(failure) {
                      
                      failure(error);
                  }
              }];
}




@end
