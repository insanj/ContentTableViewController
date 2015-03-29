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
 *  Optional delegate for extra appearance customizability (using @p startedBeingTouched: and @p startedBeingTouched: for touch events).
 */
/*@protocol ContentTableViewCellDelegate <NSObject>

@required
- (void)contentTableViewCell:(ContentTableViewCell *)cell startedBeingTouched:(UITouch *)touch;
- (void)contentTableViewCell:(ContentTableViewCell *)cell stoppedBeingTouched:(UITouch *)touch;

@end*/

/**
 *  Superclass for all content-holding cells in a @p ContentTableViewController -- which does not include empty or placeholder cells.
 */
@interface ContentTableViewCell : UITableViewCell

/**
 *  Tap-recognizing button which replaces the (frequently buggy) selection property of @p UITableViewCells. Using
 */
@property (strong, nonatomic) UIButton *contentTapButton;

// @property (nonatomic, readwrite) BOOL setDetectableSinceDequeue;

/**
 *  Updates cell appearance based on appearance properties of @p ContentTableViewController.
 */
- (void)setParentController:(ContentTableViewController *)parentController;

@end
