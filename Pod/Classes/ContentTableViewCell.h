//
//  ContentTableViewCell.h
//  ContentTableViewCell
//
//  Created by Julian Weiss on 3/26/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentTableViewController;

@interface ContentTableViewCell : UITableViewCell

@property (strong, nonatomic) UIButton *contentTapButton;

- (void)setParentController:(ContentTableViewController *)parentController;

@end
