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

@end

@implementation INSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *stringItem = @"Hello world";
	NSArray *stringArrayItem = @[@"Each of these strings", @"goes on a separate line"];
	
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(100.0, 100.0), NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
	CGContextFillRect(context, CGRectMake(0.0, 0.0, 100.0, 100.0));
	
	UIImage *imageItem = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	ContentTableViewController *contentController = [[ContentTableViewController alloc] initWithItems:@[stringItem, stringArrayItem, imageItem]];
	contentController.contentDelegate = self;
	self.viewControllers = @[contentController];
}

- (void)contentTableViewController:(ContentTableViewController *)controller didTapItem:(NSObject *)item {
	NSLog(@"%@ was tapped", item);
}

@end
