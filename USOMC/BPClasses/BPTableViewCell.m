//
//  BPTableViewCell.m
//  USOMC
//
//  Created by Allison Leong on 11/10/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPTableViewCell.h"

@implementation BPTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
