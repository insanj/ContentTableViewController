//
//  ContentTableViewCell.h
//  ContentTableViewCell
//
//  Created by Julian Weiss on 3/26/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentTableViewController, ContentTableViewCell ;

/**
 *  Superclass for all content-holding cells in a @p ContentTableViewController -- which does not include empty or placeholder cells.
 */
@interface ContentTableViewCell : UITableViewCell

/**
 *  Tap-recognizing button which replaces the (frequently buggy) selection property of @p UITableViewCells. Only needs to be used internally, as it provides the information for @p contentTableViewController:cellStartedBeingTouched: and its sister method.
 */
@property (strong, nonatomic) UIButton *contentTapButton;

/**
 *  Updates cell appearance based on appearance properties of @p ContentTableViewController.
 */
- (void)setParentController:(ContentTableViewController *)parentController;

@end
