//
//  MainViewController.m
//  OpenWeatherTest
//
//  Created by Alex Zbirnik on 10.10.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

@property (weak, nonatomic) IBOutlet UILabel *cityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedNumberLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Actions

- (IBAction)currentLocationButtonAction:(UIButton *)sender {
}


@end
