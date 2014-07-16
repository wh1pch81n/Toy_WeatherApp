//
//  MasterViewController.m
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "WeatherObject.h"
#import "WTableViewCell.h"

NSString *const kURLWeather = @"http://api.openweathermap.org/data/2.5/forecast/daily?q=San%20Jose&mode=JSON&units=imperial&cnt=7";
NSString *const kWeatherImageURLpath = @"http://openweathermap.org/img/w/";

@interface MasterViewController () {
    NSMutableArray *_objects;
    CLLocationCoordinate2D currLocation;
}


@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self getData];
}

- (void)getData {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:kURLWeather]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           if (connectionError) {
                                               NSLog(@"Error: %@", connectionError.description);
                                               return;
                                           }
                                           NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                            NSDictionary *url_args = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                           NSLog(@"%@", url_args);
                                           
                                          // WeatherObject *wo = [[WeatherObject alloc] initWithDict:url_args[@"list"][0]];
                                           
                                           currLocation.latitude = [url_args[@"city"][@"coord"][@"lat"] doubleValue];
                                           currLocation.longitude = [url_args[@"city"][@"coord"][@"lon"] doubleValue];
                                           
                                           [self initializeArrayWithWeatherObjects:url_args[@"list"]];
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [self.tableView reloadData];
                                           });
                                       }];
}


- (void)initializeArrayWithWeatherObjects:(NSArray *)list {
    _objects = [NSMutableArray new];
    if (list == nil) return;
    
    for (int i = 0; i < list.count; ++i) {
        WeatherObject *wo = [[WeatherObject alloc] initWithDict:list[i]];
        [_objects addObject:wo];
    }
    NSLog(@"%@", _objects);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    WeatherObject *object = _objects[indexPath.row];
    cell.desc.text = [object description];
    cell.Daylabel.text = [self getDay:indexPath.row];
    [self setImageWithIcon:[object icon] indexPath:indexPath];
    return cell;
}

- (void)setImageWithIcon:(NSString *)icon indexPath:(NSIndexPath *)indexpath{
    //Image calls should be asyncrhounous
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:[NSString stringWithFormat:@"%@.png", icon]
                                relativeToURL:
                         [NSURL URLWithString:kWeatherImageURLpath]]];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           //add image here on main queue
            WTableViewCell *cell = (id)[self.tableView cellForRowAtIndexPath:indexpath];
            if (cell) {
                cell.weatherImageView.image = img;
            }
        });
    });
}

- (NSString *)getDay:(NSInteger)dayNum {
    NSString *day = @"unknown day";
    switch (dayNum) {
        case 0:
            day = @"Sunday";
            break;
        case 1:
            day = @"Monday";
            break;
        case 2:
            day = @"Tuesday";
            break;
        case 3:
            day = @"Wednesday";
            break;
        case 4:
            day = @"Thursday";
            break;
        case 5:
            day = @"Friday";
            break;
        case 6:
            day = @"Saturday";
            break;
        default:
            break;
    }
    return day;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WeatherObject *object = _objects[indexPath.row];
        [[segue destinationViewController] setCurrlocation:currLocation];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
