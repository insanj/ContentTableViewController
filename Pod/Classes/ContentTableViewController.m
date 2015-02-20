//
//  ContentTableViewController.m
//  ContentTableViewController
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import "ContentTableViewController.h"
#import "ContentTableViewStringCell.h"
#import "ContentTableViewImageCell.h"
#import "ContentTableViewViewCell.h"

static NSString *kContentTablePlaceholderIdentifier = @"ContentTable.Placeholder", *kContentTableStringIdentifier = @"ContentTable.String", *kContentTableImageIdentifier = @"ContentTable.Image", *kContentTableViewIdentifier = @"ContentTable.View";

@interface ContentTableViewController ()

@property (nonatomic, readwrite) BOOL isDisplaying;

@end

@implementation ContentTableViewController

- (instancetype)init {
	self = [super init];
	
	if (self) {
		[self commonInit];
	}
	
	return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	
	if (self) {
		[self commonInit];
	}
	
	return self;
}

- (instancetype)initWithItems:(NSArray *)items {
	self = [super initWithStyle:UITableViewStylePlain];
	
	if (self) {
		[self commonInit];
		self.items = items;
	}
	
	return self;
}

- (void)commonInit {
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.itemCellInsets = UIEdgeInsetsMake(10.0, 5.0, 10.0, 5.0);
	self.itemCellBackgroundColor = [UIColor clearColor];
	self.itemCellTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:18.0]};
	self.itemCellLinkAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:18.0], NSForegroundColorAttributeName : [UIColor colorWithRed:54/255.0 green:136/255.0 blue:251/255.0 alpha:1.0]};
	self.itemCellContentMode = UIViewContentModeLeft;
	self.items = @[];
	
	UILabel *placeholderLabel = [[UILabel alloc] init];
	placeholderLabel.font = [UIFont boldSystemFontOfSize:16.0];
	placeholderLabel.textColor = [UIColor darkGrayColor];
	placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"No Items Found" attributes:self.itemCellTextAttributes];
	placeholderLabel.textAlignment = NSTextAlignmentCenter;
	placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.emptyPlaceholderView = placeholderLabel;
	
	[self.tableView registerClass:[ContentTableViewStringCell class] forCellReuseIdentifier:kContentTableStringIdentifier];
	[self.tableView registerClass:[ContentTableViewImageCell class] forCellReuseIdentifier:kContentTableImageIdentifier];
	[self.tableView registerClass:[ContentTableViewViewCell class] forCellReuseIdentifier:kContentTableViewIdentifier];

}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	self.isDisplaying = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	self.isDisplaying = NO;
}

#pragma mark - setters

- (void)setItemCellInsets:(UIEdgeInsets)itemCellInsets {
	_itemCellInsets = itemCellInsets;
	
	if (self.isDisplaying) {
		[self.tableView reloadData];
	}
}

- (void)setItemCellBackgroundColor:(UIColor *)itemCellBackgroundColor {
	_itemCellBackgroundColor = itemCellBackgroundColor;
	
	if (self.isDisplaying) {
		[self.tableView reloadData];
	}
}

- (void)setItemCellTextAttributes:(NSDictionary *)itemCellTextAttributes {
	_itemCellTextAttributes = itemCellTextAttributes;
	
	if (self.isDisplaying) {
		[self.tableView reloadData];
	}
}

- (void)setItemCellContentMode:(UIViewContentMode)itemCellContentMode {
	_itemCellContentMode = itemCellContentMode;
	
	if (self.isDisplaying) {
		[self.tableView reloadData];
	}
}

- (void)setItems:(NSArray *)items {
	_items = items;
	
	// self.tableView.separatorStyle = _items.count == 0 ? UITableViewCellSeparatorStyleNone : UITableViewCellSeparatorStyleSingleLine;
	
	if (self.isDisplaying) {
		[self.tableView reloadData];
	}
}

- (void)setEmptyPlaceholderView:(UIView *)emptyPlaceholderView {
	_emptyPlaceholderView = emptyPlaceholderView;
	
	if (self.isDisplaying && self.items.count == 0) {
		[self.tableView reloadData];
	}
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (self.tableView.style == UITableViewStylePlain || self.items.count == 0) {
		return 1;
	}
	
	return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.tableView.style == UITableViewStyleGrouped ||  self.items.count == 0) {
		return 1;
	}
	
	return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.items.count == 0) {
		return 100.0; // UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size.height;
	}
	
	NSInteger itemIndex = tableView.style == UITableViewStylePlain ? indexPath.row : indexPath.section;
	NSObject *item = self.items[itemIndex];
	
	if ([item isKindOfClass:[NSString class]]) {
		NSString *stringItem = (NSString *)item;
		CGSize tableSize = UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size;
		
		CGSize stringItemSize = [stringItem boundingRectWithSize:CGSizeMake(tableSize.width - (self.itemCellInsets.left + self.itemCellInsets.right), INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.itemCellTextAttributes context:nil].size;
		
		CGFloat insetStringHeight = stringItemSize.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetStringHeight + 1;
	}
	
	else if ([item isKindOfClass:[NSAttributedString class]]) {
		NSAttributedString *attributedStringItem = (NSAttributedString *)item;
		CGSize tableSize = UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size;
		
		CGSize attributedStringItemSize = [attributedStringItem boundingRectWithSize:CGSizeMake(tableSize.width - (self.itemCellInsets.left + self.itemCellInsets.right), INFINITY) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
		
		CGFloat insetStringHeight = attributedStringItemSize.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetStringHeight + 1;
	}
	
	else if ([item isKindOfClass:[NSURL class]]) {
		NSURL *URLItem = (NSURL *)item;
		CGSize tableSize = UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size;
		
		CGSize URLItemSize = [[URLItem absoluteString] boundingRectWithSize:CGSizeMake(tableSize.width - (self.itemCellInsets.left + self.itemCellInsets.right), INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.itemCellTextAttributes context:nil].size;
		
		CGFloat insetStringHeight = URLItemSize.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetStringHeight + 1;
	}
	
	else if ([item isKindOfClass:[UIImage class]]) {
		UIImage *imageItem = (UIImage *)item;
		CGFloat insetImageHeight = imageItem.size.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetImageHeight + 1;
	}
	
	else if ([item isKindOfClass:[UIView class]]) {
		UIView *viewItem = (UIView *)item;
		CGFloat insetViewHeight = viewItem.frame.size.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetViewHeight + 1;
	}
	
	/*else if ([item isKindOfClass:[NSArray class]]) {
		NSArray *arrayItem = (NSArray *)item;
		CGFloat iteratingStringItemHeight = 0;
		CGSize tableSize = UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size;
		
		for (NSString *stringItem in arrayItem) {
	 CGSize stringItemSize = [stringItem boundingRectWithSize:CGSizeMake(tableSize.width - (self.itemCellInsets.left + self.itemCellInsets.right), INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.itemCellTextAttributes context:nil].size;
	 iteratingStringItemHeight += stringItemSize.height + 1.0;
		}
		
		CGFloat insetStringHeight = iteratingStringItemHeight + self.itemCellInsets.top + self.itemCellInsets.bottom;
		return insetStringHeight;
	 }*/
	
	return 0;
}

#pragma mark delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.items.count == 0) {
		UITableViewCell *placeholderCell = [tableView dequeueReusableCellWithIdentifier:kContentTablePlaceholderIdentifier];
		
		if (!placeholderCell) {
			placeholderCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentTablePlaceholderIdentifier];
			placeholderCell.backgroundColor = [UIColor clearColor];
			placeholderCell.selectionStyle = UITableViewCellSelectionStyleNone;
			placeholderCell.userInteractionEnabled = NO;
			
			self.emptyPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
			[placeholderCell.contentView addSubview:self.emptyPlaceholderView];

			NSLayoutConstraint *centerXAnchorAttribute = [NSLayoutConstraint constraintWithItem:self.emptyPlaceholderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:placeholderCell.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
			NSLayoutConstraint *centerYAnchorAttribute = [NSLayoutConstraint constraintWithItem:self.emptyPlaceholderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:placeholderCell.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
			[placeholderCell.contentView addConstraints:@[centerXAnchorAttribute, centerYAnchorAttribute]];
		}
		
		return placeholderCell;
	}
	
	NSInteger itemIndex = self.tableView.style == UITableViewStylePlain ? indexPath.row : indexPath.section;
	NSObject *item = self.items[itemIndex];
	
	if ([item isKindOfClass:[NSString class]]) {
		NSString *stringItem = (NSString *)item;
		
		ContentTableViewStringCell *stringCell = [tableView dequeueReusableCellWithIdentifier:kContentTableStringIdentifier forIndexPath:indexPath];
		stringCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
		stringCell.displayString = [[NSAttributedString alloc] initWithString:stringItem attributes:self.itemCellTextAttributes];
		[stringCell setParentController:self];
		return stringCell;
	}
	
	else if ([item isKindOfClass:[NSAttributedString class]]) {
		NSAttributedString *attributedStringItem = (NSAttributedString *)item;
		
		ContentTableViewStringCell *stringCell = [tableView dequeueReusableCellWithIdentifier:kContentTableStringIdentifier forIndexPath:indexPath];
		stringCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
		stringCell.displayString = attributedStringItem;
		[stringCell setParentController:self];
		return stringCell;
	}
	
	else if ([item isKindOfClass:[NSURL class]]) {
		NSURL *URLItem = (NSURL *)item;
		
		ContentTableViewStringCell *stringCell = [tableView dequeueReusableCellWithIdentifier:kContentTableStringIdentifier forIndexPath:indexPath];
		stringCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
		stringCell.displayString = [[NSAttributedString alloc] initWithString:[URLItem absoluteString] attributes:self.itemCellLinkAttributes];
		[stringCell setParentController:self];
		return stringCell;
	}
	
	else if ([item isKindOfClass:[UIImage class]]) {
		UIImage *imageItem = (UIImage *)item;
		
		ContentTableViewImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kContentTableImageIdentifier forIndexPath:indexPath];
		imageCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
		imageCell.displayImage = imageItem;
		[imageCell setParentController:self];
		return imageCell;
	}
	
	else if ([item isKindOfClass:[UIView class]]) {
		UIView *viewItem = (UIView *)item;
		
		ContentTableViewViewCell *viewCell = [tableView dequeueReusableCellWithIdentifier:kContentTableViewIdentifier forIndexPath:indexPath];
		viewCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
		viewCell.displayView = viewItem;
		[viewCell setParentController:self];
		return viewCell;
	}
	
	/*else if ([item isKindOfClass:[NSArray class]]) {
		NSArray *arrayItem = (NSArray *)item;
		
		NSMutableString *completeString = [NSMutableString stringWithString:[arrayItem firstObject]];
		for (int i = 1; i < arrayItem.count; i++) {
			[completeString appendString:@"\n"];
			[completeString appendString:arrayItem[i]];
		}
		
		ContentTableViewStringCell *stringCell = [tableView dequeueReusableCellWithIdentifier:kContentTableStringIdentifier forIndexPath:indexPath];
		stringCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
		stringCell.displayString = [[NSAttributedString alloc] initWithString:completeString attributes:self.itemCellTextAttributes];
		[stringCell setParentController:self];
		return stringCell;
	}*/
	
    return nil;
}
							 
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.contentView.backgroundColor = self.itemCellBackgroundColor;
	
	// Special thanks to http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsMake(0, self.itemCellInsets.left, 0, self.itemCellInsets.right)];
	}
	
	// Prevent the cell from inheriting the table view's margin settings
	if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
		[cell setPreservesSuperviewLayoutMargins:NO];
	}
	
	// Explictly set your cell's layout margins
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsMake(0, self.itemCellInsets.left, 0, self.itemCellInsets.right)];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (self.contentDelegate) {
		NSInteger itemIndex = self.tableView.style == UITableViewStylePlain ? indexPath.row : indexPath.section;
		[self.contentDelegate contentTableViewController:self didTapItem:self.items[itemIndex]];
	}
}
							 
@end
