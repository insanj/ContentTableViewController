//
//  INSViewController.m
//  ContentTableViewController
//
//  Created by insanj on 02/20/2015.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "INSViewController.h"
#import "ContentTableViewController.h"
#import "ContentTableViewCell.h"

@interface INSViewController () <ContentTableViewControllerDelegate>

@property (strong, nonatomic) ContentTableViewController *contentController;

@property (nonatomic, readwrite) BOOL animatingForTouch, animatingForUntouch;

@end

@implementation INSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.contentController = [[ContentTableViewController alloc] init];
	self.contentController.contentDelegate = self;
	self.contentController.title = @"Example Content";
	self.contentController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped:)];
	
	self.viewControllers = @[self.contentController];
}

#pragma mark - actions

- (void)refreshButtonTapped:(UIBarButtonItem *)sender {
	NSString *stringItem = @"Hello world";
	
	NSAttributedString *attributeStringItem = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
	
	NSURL *linkItem = [NSURL URLWithString:@"https://github.com/insanj/ContentTableViewController"];
    
    ContentVideoItem *videoItem = [ContentVideoItem itemWithURL:[NSURL URLWithString:@"https://ia800300.us.archive.org/7/items/electricsheep-flock-244-72500-3/00244=72533=72533=72533.mp4"]];
	
	UIImage *wideImageItem = [UIImage imageNamed:@"cheese"];
	UIImage *tallImageItem = [UIImage imageNamed:@"empire"];
	UIImage *squareImageItem = [UIImage imageNamed:@"album"];
	UIImage *smallImageItem = [UIImage imageNamed:@"yosemite"];

	UIButton *viewItem = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
	[viewItem addTarget:self action:@selector(viewItemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	viewItem.backgroundColor = [UIColor blueColor];
	viewItem.layer.masksToBounds = YES;
	viewItem.layer.cornerRadius = 25.0;
	
	self.contentController.items = @[stringItem, videoItem, attributeStringItem, linkItem, wideImageItem, tallImageItem, squareImageItem, smallImageItem, viewItem];
}

- (void)viewItemButtonTapped:(UIButton *)sender {
	NSLog(@"%@ button was tapped", sender);
}

#pragma mark - content controller

- (void)contentTableViewController:(ContentTableViewController *)controller didTapItem:(NSObject *)item {
	NSLog(@"%@ was tapped", item);
	if ([item isKindOfClass:[NSURL class]]) {
		[[UIApplication sharedApplication] openURL:(NSURL *)item];
	}
}

- (void)contentTableViewController:(ContentTableViewController *)controller cellStartedBeingTouched:(ContentTableViewCell *)cell {
	[UIView animateWithDuration:0.2 animations:^{
		cell.contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
	} completion:NULL];
}

- (void)contentTableViewController:(ContentTableViewController *)controller cellStoppedBeingTouched:(ContentTableViewCell *)cell {
	[UIView animateWithDuration:0.2 animations:^{
		cell.contentView.backgroundColor = [UIColor whiteColor];
	} completion:NULL];
}

/*
 
 Much more advanced cell touch implementation, in case there are some fancy effects or some such with cell events.
 
#define TOUCH_ANIMATION_TIME 0.2

- (void)animateCellForTouch:(ContentTableViewCell *)cell {
	if (!_animatingForTouch) {
		_animatingForTouch = YES;
		[UIView animateWithDuration:TOUCH_ANIMATION_TIME animations:^{
			cell.contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
		} completion:^(BOOL finished) {
			_animatingForTouch = NO;
		}];
	}
	
	else if (_animatingForUntouch) {
		[self performSelector:@selector(animateCellForTouch:) withObject:cell afterDelay:TOUCH_ANIMATION_TIME];
	}
}

- (void)animateCellForUntouch:(ContentTableViewCell *)cell {
	if (!_animatingForUntouch) {
		_animatingForUntouch = YES;
		[UIView animateWithDuration:TOUCH_ANIMATION_TIME animations:^{
			cell.contentView.backgroundColor = [UIColor whiteColor];
		} completion:^(BOOL finished) {
			_animatingForUntouch = NO;
		}];
	}
	
	else if (_animatingForTouch) {
		[self performSelector:@selector(animateCellForUntouch:) withObject:cell afterDelay:TOUCH_ANIMATION_TIME];
	}
}
*/

@end
