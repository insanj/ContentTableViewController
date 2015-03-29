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
 *  Optional delegate method for extra appearance customizability, to be used in conjunction with @p contentTableViewController:cellStoppedBeingTouched:
 */
- (void)contentTableViewController:(ContentTableViewController *)controller cellStartedBeingTouched:(ContentTableViewCell *)cell;

/**
 *  Optional delegate method for extra appearance customizability, to be used in conjunction with @p contentTableViewController:cellStartedBeingTouched:
 */
- (void)contentTableViewController:(ContentTableViewController *)controller cellStoppedBeingTouched:(ContentTableViewCell *)cell;

@required

- (void)contentTableViewController:(ContentTableViewController *)controller didTapItem:(NSObject *)item;

@end

#endif
