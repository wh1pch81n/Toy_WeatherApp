//
//  WTableViewCell.m
//  weatherApp
//
//  Created by Derrick Ho on 7/15/14.
//  Copyright (c) 2014 dnthome. All rights reserved.
//

#import "WTableViewCell.h"

@implementation WTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
