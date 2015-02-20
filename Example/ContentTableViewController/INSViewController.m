//
//  INSViewController.m
//  ContentTableViewController
//
//  Created by insanj on 02/20/2015.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "INSViewController.h"
#import "ContentTableViewController.h"

@interface INSViewController () <ContentTableViewControllerDelegate>

@property (strong, nonatomic) ContentTableViewController *contentController;

@end

@implementation INSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.contentController = [[ContentTableViewController alloc] init];
	self.contentController.contentDelegate = self;
	// self.contentController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.contentController.title = @"Example Content";
	self.contentController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped:)];
	
	self.viewControllers = @[self.contentController];
}

#pragma mark - actions

- (void)refreshButtonTapped:(UIBarButtonItem *)sender {
	NSString *stringItem = @"Hello world";
	
	NSArray *stringArrayItem = @[@"Each of these strings", @"goes on a separate line"];
	
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(100.0, 100.0), NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
	CGContextFillRect(context, CGRectMake(0.0, 0.0, 100.0, 100.0));
	UIImage *imageItem = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.contentController.items = @[stringItem, stringArrayItem, imageItem];
}

#pragma mark - content controller

- (void)contentTableViewController:(ContentTableViewController *)controller didTapItem:(NSObject *)item {
	NSLog(@"%@ was tapped", item);
}

@end
