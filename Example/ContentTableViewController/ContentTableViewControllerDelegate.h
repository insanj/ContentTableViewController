//
//  ContentTableViewControllerDelegate.h
//  ContentTableViewController
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#ifndef ContentTableViewController_ContentTableViewControllerDelegate_h
#define ContentTableViewController_ContentTableViewControllerDelegate_h

@class ContentTableViewController;

@protocol ContentTableViewControllerDelegate <NSObject>

@required
- (void)contentTableViewController:(ContentTableViewController *)controller didTapItem:(NSObject *)item;

@end

#endif
