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
 *  Insets applied to the inside of the cell, defaults to @b 0.
 */
@property (nonatomic, readwrite) UIEdgeInsets itemCellInsets UI_APPEARANCE_SELECTOR;

/**
 *  Background color of each item cell, defaults to @p clearColor with the @p tableView itself being @p whiteColor.
 */
@property (strong, nonatomic) UIColor *itemCellBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 *  Font used when drawing @p NSString or @p NSString-containing items.
 */
@property (strong, nonatomic) UIFont *itemCellFont UI_APPEARANCE_SELECTOR;

/**
 *  Content display mode of each item cell, applied to the principal displaying object.
 */
@property (nonatomic, readwrite) UIViewContentMode itemCellContentMode UI_APPEARANCE_SELECTOR;

/**
 *  All items currently displayed, defaults to an empty array, with a empty state for the table.
 *	@p NSString, @p NSArray of @p NSStrings (each displays as a separate line), @p UIImage
 */
@property (strong, nonatomic) NSArray *items;

/**
 *  Placeholder view shown when the table has an empty state.
 */
@property (strong, nonatomic) UIView *emptyPlaceholderView;

/**
 *  Optional delegate which handles taps on item cells. By default, cells are not interactable.
 */
@property (strong, nonatomic) NSObject<ContentTableViewControllerDelegate> *contentDelegate;

/**
 *  Create a new @p ContentTableViewController instance with given items (conforming to the equivalent propery, @p items).
 */
- (instancetype)initWithItems:(NSArray *)items;

@end
