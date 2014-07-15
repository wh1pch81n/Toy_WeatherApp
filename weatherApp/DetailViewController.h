//
//  DetailViewController.h
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
