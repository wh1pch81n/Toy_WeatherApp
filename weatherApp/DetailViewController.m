//
//  DetailViewController.m
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import "DetailViewController.h"
#import "WeatherObject.h"

NSString *const kWeatherImageURLpath_ = @"http://openweathermap.org/img/w/";

@interface DetailViewController ()
- (void)configureView;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *tempHi;
@property (weak, nonatomic) IBOutlet UILabel *tempLo;
@property (strong, nonatomic) NSDictionary *allTemps;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;

#pragma mark - MKAnnotation

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (NSString *)title;
- (NSString *)subtitle;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        [NSURLConnection sendAsynchronousRequest:
         [NSURLRequest requestWithURL:
          [NSURL URLWithString:
           [[kWeatherImageURLpath_ stringByAppendingPathComponent:_detailItem.icon]
            stringByAppendingPathExtension:@"png"]]]
                                           queue:[NSOperationQueue new]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError) {
                                       return;
                                   }
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       _image.image = [UIImage imageWithData:data];
                                   });
                               }];
        _desc.text = _detailItem.description;
        _tempHi.text = [_detailItem.temp[@"max"] stringValue];
        _tempLo.text = [_detailItem.temp[@"min"] stringValue];
        _allTemps = _detailItem.temp;
        _humidity.text = _detailItem.humidity.stringValue;
        _pressure.text = _detailItem.pressure.stringValue;
        _speed.text = _detailItem.speed.stringValue;
        
        MKCoordinateRegion region;
        region.center.latitude = _currlocation.latitude;
        region.center.longitude = _currlocation.longitude;
        region.span.latitudeDelta = 0.5;
        region.span.longitudeDelta = 0.5;
        
        [self.mapKit addAnnotation:self];
        [self.mapKit setRegion:region animated:YES];
        
//        MKAnnotationView * av = [self.mapKit viewForAnnotation:self];
//        av.backgroundColor = [UIColor whiteColor];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MKAnnotation

- (CLLocationCoordinate2D) coordinate { return _currlocation;}

- (NSString *)title {return @"You are here";};
- (NSString *)subtitle {return @"I can see my house from here!";}

@end
