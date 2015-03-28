//
//  ContentTableViewControllerDelegate.h
//  ContentTableViewController
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#ifndef ContentTableViewController_ContentTableViewControllerDelegate_h
#define ContentTableViewController_ContentTableViewControllerDelegate_h

@class ContentTableViewController, ContentTableViewCell;

@protocol ContentTableViewControllerDelegate <NSObject>

@optional

/**
 *  Optional delegate method for extra appearance customizability (using this to add actions for any @p UIControlEvent on the @p cell's @p contentTapButton). Recommended to change appearance for @p touchDown here, then add action for @p touchUp which then removes itself after firing.
 */
- (void)contentTableViewController:(ContentTableViewController *)controller cellStartingBeingTouched:(ContentTableViewCell *)cell;

@required

- (void)contentTableViewController:(ContentTableViewController *)controller didTapItem:(NSObject *)item;

@end

#endif
