//
//  ContentTableViewViewCell.h
//  
//
//  Created by Julian Weiss on 2/20/15.
//
//

#import <UIKit/UIKit.h>

@class ContentTableViewController;

@interface ContentTableViewViewCell : UITableViewCell

@property (strong, nonatomic) UIView *displayView;

- (void)setParentController:(ContentTableViewController *)parentController;

@end
