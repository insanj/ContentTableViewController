//
//  ContentTableViewImageCell.h
//  Pods
//
//  Created by Julian Weiss on 2/20/15.
//
//

#import <UIKit/UIKit.h>

@class ContentTableViewController;

@interface ContentTableViewImageCell : UITableViewCell

@property (strong, nonatomic) UIImage *displayImage;

- (void)setParentController:(ContentTableViewController *)parentController;

@end
