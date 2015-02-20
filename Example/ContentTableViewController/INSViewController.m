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
	
	// NSArray *stringArrayItem = @[@"Each of these strings", @"goes on a separate line"];
	
	NSAttributedString *attributeStringItem = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
	
	NSURL *linkItem = [NSURL URLWithString:@"https://github.com/insanj/ContentTableViewController"];
	
	UIImage *imageItem = [UIImage imageNamed:@"yosemite.png"];
		
	UIButton *viewItem = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
	[viewItem addTarget:self action:@selector(viewItemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	viewItem.backgroundColor = [UIColor blueColor];
	viewItem.layer.masksToBounds = YES;
	viewItem.layer.cornerRadius = 25.0;
	
	self.contentController.items = @[stringItem, attributeStringItem, linkItem, imageItem, viewItem];
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

@end
