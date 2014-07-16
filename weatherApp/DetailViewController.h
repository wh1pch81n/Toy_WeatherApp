//
//  DetailViewController.h
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class WeatherObject;
@interface DetailViewController : UITableViewController <MKMapViewDelegate, MKAnnotation>

@property (strong, nonatomic) WeatherObject *detailItem;
@property CLLocationCoordinate2D currlocation;

@end
