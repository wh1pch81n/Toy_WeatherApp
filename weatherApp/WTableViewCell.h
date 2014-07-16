//
//  WTableViewCell.h
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Daylabel;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImageView;

@end
