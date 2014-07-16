//
//  WeatherObject.h
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherObject : NSObject

@property (strong, nonatomic) NSNumber *clouds;
@property (strong, nonatomic) NSNumber *deg;
@property (strong, nonatomic) NSNumber *dt;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber *pressure;
@property (strong, nonatomic) NSNumber *rain;
@property (strong, nonatomic) NSNumber *speed;
@property (strong, nonatomic) NSDictionary *temp;

@property (strong, nonatomic) NSString *icon;

@property (strong, nonatomic) NSString *description; //is it raining?

- (id)initWithDict:(NSDictionary *)dict;

@end
