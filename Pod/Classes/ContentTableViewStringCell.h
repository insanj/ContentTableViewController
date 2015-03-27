//
//  ContentTableViewStrinCell.h
//  ContentTableViewStringCell
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import "ContentTableViewCell.h"

@class ContentTableViewController;

@interface ContentTableViewStringCell : ContentTableViewCell

@property (strong, nonatomic) NSAttributedString *displayString;

@end
