//
//  ViewController.m
//  LocationDemo
//
//  Created by gaiaworks on 16/4/26.
//  Copyright © 2016年 gaiaworks. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

#pragma mark - Accessor

- (void)setLocationManager:(CLLocationManager *)locationManager {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500; // meters
    _locationManager = locationManager;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRect = [eventDate timeIntervalSinceNow];
    if (fabs(howRect) < 15.0) {
        NSLog(@"latitude %+.6f, longtitude %+.6f", location.coordinate.latitude, location.coordinate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
}

#pragma mark - Action

- (IBAction)startLocate:(id)sender {
    
    self.locationManager = [CLLocationManager new];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }else {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

@end








