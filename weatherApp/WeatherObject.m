//
//  WeatherObject.m
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import "WeatherObject.h"

@implementation WeatherObject

- (id)initWithDict:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.clouds = (NSNumber *)dict[@"clouds"];
        self.deg  = dict[@"deg"];
        self.dt = dict[@"dt"];
        self.humidity = dict[@"humidity"];
        self.pressure = dict[@"pressure"];
        self. rain = dict[@"rain"];
        self. speed = dict[@"speed"];
        self.temp = dict[@"temp"]; //a dict of temps throuout the day.
        
        self.icon = dict[@"weather"][0][@"icon"];
        
        self.description = dict[@"weather"][0][@"description"]; 
    }
    return self;
}

@end
