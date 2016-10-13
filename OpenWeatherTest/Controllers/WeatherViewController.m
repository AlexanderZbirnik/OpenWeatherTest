//
//  WeatherViewController.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 10.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "WeatherViewController.h"
#import "SearchCitiesViewController.h"
#import "LocationButton.h"
#import "CitiesContainerView.h"
#import "CitySearchBar.h"
#import "DarkView.h"

#import "AFNetworking.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

#import "LocationManager.h"
#import "WeatherManager.h"

#import "Weather.h"
#import "Weather+Parser.h"

@interface WeatherViewController () < GMSMapViewDelegate, SearchCitiesViewControllerDelegate >

@property (weak, nonatomic) IBOutlet CitySearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *orTitleLabel;
@property (weak, nonatomic) IBOutlet LocationButton *currentLocationButton;

@property (weak, nonatomic) IBOutlet UILabel *cityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedNumberLabel;

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet DarkView *darkView;
@property (weak, nonatomic) IBOutlet CitiesContainerView *citiesContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *citiesHeightConstraint;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@property (assign, nonatomic) BOOL visibleCities;


@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view sendSubviewToBack:self.darkView];
    [self.view insertSubview:self.citiesContainerView aboveSubview:self.darkView];
    [self.currentLocationButton setBorderWidth:2.f];
    
    self.visibleCities = NO;

    [self defaultMapSettings];

    [self addNotifications];
    [self manageChildViewControllers];
}

#pragma mark - Private controller methods

- (void) manageChildViewControllers {
    
    for (id object in self.childViewControllers) {
        
        if ([object isKindOfClass: [SearchCitiesViewController class]]) {
            
            SearchCitiesViewController *searchCitiesController = (SearchCitiesViewController *) object;
            
            self.delegate = searchCitiesController;
            searchCitiesController.delegate = self;
        }
    }
}

- (void) updateWeatherInformationFromDict: (NSDictionary *) dict {
    
    Weather *currentWeather = [[Weather alloc] init];
    [currentWeather parseOpenWeatherJSONDict:dict];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self stopIndicators];
        
        self.cityNameLabel.text = currentWeather.city;
        self.temperatureNumberLabel.text = currentWeather.temperature;
        self.humidityNumberLabel.text = currentWeather.humidity;
        self.windSpeedNumberLabel.text = currentWeather.windSpeed;
    });
}

- (void) removeWeatherInformation {
    
    self.cityNameLabel.text = @"";
    self.temperatureNumberLabel.text = @"";
    self.humidityNumberLabel.text = @"";
    self.windSpeedNumberLabel.text = @"";
}

- (void) cancelSearchCity {
    
    [self.searchBar endEditing:YES];
    self.searchBar.text = @"";
    self.visibleCities = NO;
    
    [self.darkView animatedDisappearance];
    [self.citiesContainerView animatedDisappearance];
    
    [self.view sendSubviewToBack:self.darkView];
    [self.view insertSubview:self.citiesContainerView aboveSubview:self.darkView];
}

- (void) startIndicators {
    
    [self.activityIndicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self removeWeatherInformation];
}

- (void) stopIndicators {
    
    [self.activityIndicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Private googleMap methods

- (void) defaultMapSettings {
    
    self.mapView.delegate = self;
    self.mapView.myLocationEnabled = NO;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(49.13443247522099, 30.83988435566425);
    
    [self moveMapToCoordinate:coordinate andZoom:6.f];
}

- (void) moveMapToCoordinate: (CLLocationCoordinate2D) coordinate andZoom: (CGFloat) zoom {
    
    [self.mapView clear];
    
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:coordinate zoom:zoom];
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setCamera:cameraPosition];
    
    [self.mapView moveCamera:cameraUpdate];
}

- (void) addMarkerToCoordinate: (CLLocationCoordinate2D) coordinate {
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    UIColor *iconColor =
    [UIColor colorWithRed:0.f/255.f green:186.f/255.f blue:58.f/255.f alpha:1];
    marker.icon = [GMSMarker markerImageWithColor:iconColor];
    marker.position = coordinate;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
}

#pragma mark - SearchCitiesViewControllerDelegate

- (void) searchCitiesViewController: (SearchCitiesViewController *) searchCitiesViewController cityName: (NSString *) name address: (NSString *) address latitude: (double) latitude longitude: (double) longitude {
    
    self.currentLocationButton.enabled = YES;
    
    [self startIndicators];
    [self cancelSearchCity];

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    [self moveMapToCoordinate:coordinate andZoom:12.f];
    [self addMarkerToCoordinate:coordinate];

    [[WeatherManager sharedInstance] weatherWithCityName:address success:^(NSDictionary *dict) {
        
        [self updateWeatherInformationFromDict:dict];
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"error: %@", error);
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self.view insertSubview:self.darkView belowSubview:self.searchBar];
    [self.darkView animatedAppearance];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
   
    [self.delegate weatherViewController:self textDidChange:searchText];
    
    if (self.visibleCities == NO) {
        
        [self.view insertSubview:self.citiesContainerView aboveSubview:self.darkView];
        [self.citiesContainerView animatedAppearance];
        
        self.visibleCities = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar endEditing:YES];
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    self.currentLocationButton.enabled = YES;
    
    [self startIndicators];
    
    [self.mapView clear];
    [self addMarkerToCoordinate:coordinate];
    
    [[WeatherManager sharedInstance] weatherWithLatitude:coordinate.latitude
                                            andLongitude:coordinate.longitude
                                                 success:^(NSDictionary *dict) {
                                                     
                                                     [self updateWeatherInformationFromDict:dict];
                                                 }
                                               onFailure:^(NSError *error) {
                                                   
                                                   NSLog(@"error: %@", [error localizedDescription]);
                                               }];

}

#pragma mark - Actions

- (IBAction)currentLocationButtonAction:(LocationButton *)sender {
    
    [[LocationManager sharedInstance] updateLocation];
}

- (IBAction)cancelSearchCityAction:(id)sender {
    
    [self cancelSearchCity];
}

#pragma mark - Notifications

- (void) addNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLocationNotification:)
                                                 name:LocationManagerUpdateLocationNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void) updateLocationNotification: (NSNotification *) notification {

    self.currentLocationButton.enabled = NO;
    
    [self startIndicators];
    
    NSValue *coordinateValue = [notification.userInfo objectForKey:LocationManagerCoordinateUserInfoKey];
    CLLocationCoordinate2D coordinate;
    
    [coordinateValue getValue:&coordinate];
    
    [self moveMapToCoordinate:coordinate andZoom:14.f];
    
    [[WeatherManager sharedInstance] weatherWithLatitude:coordinate.latitude
                                            andLongitude:coordinate.longitude
                                                 success:^(NSDictionary *dict) {

                                                     [self updateWeatherInformationFromDict:dict];
                                                 }
                                               onFailure:^(NSError *error) {
                                                   
                                                   NSLog(@"error: %@", [error localizedDescription]);
                                               }];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    NSValue *keyboardFrameValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [keyboardFrameValue CGRectValue];
    
    CGFloat minYkeyboard = CGRectGetMinY(keyboardFrame);
    
    // total offsets between searchScreen and searchFiels && the between searchScreen keyboard
    CGFloat offsetAxisYpotraint = 32.f;
    CGFloat offsetAxisYlandscape = 16.f;
    
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    BOOL isPortrait = UIDeviceOrientationIsPortrait(currentOrientation);
    
    if (isPortrait) {
        
        CGFloat maxYSerachBar = CGRectGetMaxY(self.searchBar.frame);
        CGFloat citiesHeight = minYkeyboard - maxYSerachBar;
        
        self.citiesHeightConstraint.constant = citiesHeight - offsetAxisYpotraint;
                
    } else {
        
        CGFloat citiesMinY = CGRectGetMinY(self.citiesContainerView.frame);
        CGFloat citiesHeight = minYkeyboard - citiesMinY;
        
        self.citiesHeightConstraint.constant = citiesHeight - offsetAxisYlandscape;
    }
    
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];

}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
