//
//  ContentTableViewStringCell.h
//  Pods
//
//  Created by Julian Weiss on 2/20/15.
//
//

#import <UIKit/UIKit.h>

@class ContentTableViewController;

@interface ContentTableViewStringCell : UITableViewCell

@property (strong, nonatomic) NSAttributedString *displayString;

- (void)setParentController:(ContentTableViewController *)parentController;

@end
