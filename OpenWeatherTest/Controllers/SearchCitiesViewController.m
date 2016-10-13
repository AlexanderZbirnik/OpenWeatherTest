//
//  SearchCitiesViewController.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 11.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "SearchCitiesViewController.h"
#import <GooglePlaces/GooglePlaces.h>

#import "City.h"
#import "City+Parser.h"

@interface SearchCitiesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *cities;

@end

@implementation SearchCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - WeatherViewControllerDelegate

- (void) weatherViewController: (WeatherViewController *) weatherViewController textDidChange:(NSString *)searchText {
    
    GMSPlacesClient *placesClient = [[GMSPlacesClient alloc] init];
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    
    self.cities = [[NSMutableArray alloc] init];
    
    __weak NSMutableArray *weakCities = self.cities;
    
    [placesClient autocompleteQuery:searchText
                             bounds:nil
                             filter:filter
                           callback:^(NSArray *results, NSError *error) {
                               
                               if (results.count == 0) {
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       
                                       [self.tableView reloadData];
                                   });
                                   
                                   return;
                                   
                               } else {
                                   
                                   for (GMSAutocompletePrediction* result in results) {
                                       
                                       GMSPlacesClient *placesClient = [[GMSPlacesClient alloc] init];
                                       
                                       [placesClient lookUpPlaceID:result.placeID callback:^(GMSPlace *place, NSError *error) {
                                           
                                           if (error != nil) {
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   
                                                   [self.tableView reloadData];
                                               });
                                               
                                               return;
                                           }
                                           
                                           if (place != nil) {
                                               
                                               City *city = [[City alloc] init];
                                               [city parseCityFromGMSPlace:place];
                                               
                                               [weakCities addObject:city];
                                           }
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               
                                               [self.tableView reloadData];
                                           });
                                       }];
                                   }
                               }
                           }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cities.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"searcedCityCell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    City *city = [self.cities objectAtIndex:indexPath.row];
    
    cell.textLabel.text = city.name;
    
    NSInteger commaAndSpaceLength = 2;
    
    if (city.address.length > city.name.length + commaAndSpaceLength) {
        
        cell.detailTextLabel.text =
        [city.address substringFromIndex:city.name.length + commaAndSpaceLength];
        
    } else {
        
        cell.detailTextLabel.text = city.address;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    City *city = [self.cities objectAtIndex:indexPath.row];
    
    [self.delegate searchCitiesViewController:self cityName:city.name address:city.address latitude:city.latitude longitude:city.longitude];
}


@end
