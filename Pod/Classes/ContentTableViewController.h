//
//  ContentTableViewController.h
//  ContentTableViewController
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentTableViewControllerDelegate.h"

@interface ContentTableViewController : UITableViewController

/**
 *  Insets applied to the inside of the cell, @b defaults to 10.0, 5.0, 10.0, 5.0
 */
@property (nonatomic, readwrite) UIEdgeInsets itemCellInsets;

/**
 *  Background color of each item cell, defaults to @b clearColor with the @p tableView itself being @p whiteColor
 */
@property (strong, nonatomic) UIColor *itemCellBackgroundColor;

/**
 *  Content display mode of each item cell, applied to the principal displaying object (e.g. @p UILabel, @p UIImageView), defaults to @b UIViewContentModeLeft
 */
@property (nonatomic, readwrite) UIViewContentMode itemCellContentMode;

/**
 *  Attributes used when drawing @p NSString items. Defaults to @p [UIFont @p fontWithName:@"AvenirNext-Regular" @p size:18.0]
 */
@property (strong, nonatomic) NSDictionary *itemCellTextAttributes;

/**
 *  Attributes used when drawing @p NSURL items. Defaults to @p [UIFont @p fontWithName:@"AvenirNext-Regular" @p size:18.0] with @b blueColor
 */
@property (strong, nonatomic) NSDictionary *itemCellLinkAttributes;

/**
 *  All items currently displayed, defaults to an empty array, with a empty state for the table.
 *	@p NSString, @p NSAttributedString, @p UIImage, @p UIView
 */
@property (strong, nonatomic) NSArray *items;

/**
 *  Placeholder view shown when the table has an empty state
 */
@property (strong, nonatomic) UIView *emptyPlaceholderView;

/**
 *  Optional delegate which handles taps on item cells. By default, cells are not interactable
 */
@property (strong, nonatomic) NSObject<ContentTableViewControllerDelegate> *contentDelegate;

/**
 *  Create a new @p ContentTableViewController instance with given items (conforming to the equivalent propery, @p items)
 */
- (instancetype)initWithItems:(NSArray *)items;

@end
