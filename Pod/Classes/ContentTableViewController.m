//
//  ContentTableViewController.m
//  ContentTableViewController
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import "ContentTableViewController.h"

static NSString *kContentTablePlaceholderIdentifier = @"ContentTable.Placeholder", *kContentTableStringIdentifier = @"ContentTable.String", *kContentTableImageIdentifier = @"ContentTable.Image";
static const NSInteger kContentTableLabelTag = 108, kCOntentTableImageViewTag = 105;

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
	
	NSMutableParagraphStyle *lineHeightParagraphStyle = [[NSMutableParagraphStyle alloc] init];
	lineHeightParagraphStyle.lineSpacing = 1.0;
	lineHeightParagraphStyle.lineHeightMultiple = 1.0;
	
	self.itemCellTextAttributes = @{NSParagraphStyleAttributeName : lineHeightParagraphStyle,
									NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:18.0]};
	self.itemCellContentMode = UIViewContentModeCenter;
	self.items = @[];
	
	UILabel *placeholderLabel = [[UILabel alloc] init];
	placeholderLabel.font = [UIFont boldSystemFontOfSize:16.0];
	placeholderLabel.textColor = [UIColor darkGrayColor];
	placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"No Items Found" attributes:self.itemCellTextAttributes];
	placeholderLabel.textAlignment = NSTextAlignmentCenter;
	placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.emptyPlaceholderView = placeholderLabel;
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
	
	// NSAssert(_itemCellTextAttributes[NSParagraphStyleAttributeName] != nil, @"itemCellTextAttributes must contain a NSParagraphStyle (under the NSParagraphStyleAttributeName key) to properly calculate cell height");
	
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
		return UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size.height;
	}
	
	NSInteger itemIndex = tableView.style == UITableViewStylePlain ? indexPath.row : indexPath.section;
	NSObject *item = self.items[itemIndex];
	
	if ([item isKindOfClass:[NSString class]]) {
		NSString *stringItem = (NSString *)item;
		CGSize tableSize = UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size;
		// CGFloat lineHeight = ((NSParagraphStyle *)self.itemCellTextAttributes[NSParagraphStyleAttributeName]).lineSpacing;
		
		CGSize stringItemSize = [stringItem boundingRectWithSize:CGSizeMake(tableSize.width - (self.itemCellInsets.left + self.itemCellInsets.right), INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.itemCellTextAttributes context:nil].size;
		
		CGFloat insetStringHeight = stringItemSize.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetStringHeight; // + lineHeight;
	}
	
	else if ([item isKindOfClass:[NSArray class]]) {
		NSArray *arrayItem = (NSArray *)item;
		CGFloat iteratingStringItemHeight = 0;
		CGSize tableSize = UIEdgeInsetsInsetRect(tableView.frame, tableView.contentInset).size;
		// CGFloat lineHeight = ((NSParagraphStyle *)self.itemCellTextAttributes[NSParagraphStyleAttributeName]).lineSpacing;
		
		for (NSString *stringItem in arrayItem) {
			CGSize stringItemSize = [stringItem boundingRectWithSize:CGSizeMake(tableSize.width - (self.itemCellInsets.left + self.itemCellInsets.right), INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.itemCellTextAttributes context:nil].size;
			iteratingStringItemHeight += stringItemSize.height + 1.0;
		}
		
		CGFloat insetStringHeight = iteratingStringItemHeight + self.itemCellInsets.top + self.itemCellInsets.bottom;
		return insetStringHeight;
	}
	
	else if ([item isKindOfClass:[UIImage class]]) {
		UIImage *imageItem = (UIImage *)item;
		CGFloat insetImageHeight = imageItem.size.height + (self.itemCellInsets.top + self.itemCellInsets.bottom);
		return insetImageHeight;
	}
	
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
		
		UITableViewCell *stringCell = [tableView dequeueReusableCellWithIdentifier:kContentTableStringIdentifier];
		if (!stringCell) {
			stringCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentTableStringIdentifier];
			stringCell.backgroundColor = [UIColor clearColor];
			stringCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
			
			UILabel *contentLabel = [[UILabel alloc] init];
			contentLabel.backgroundColor = [UIColor clearColor];
			contentLabel.contentMode = self.itemCellContentMode;
			
			switch (self.itemCellContentMode) {
				default:
				case UIViewContentModeLeft:
					contentLabel.textAlignment = NSTextAlignmentLeft;
					break;
				case UIViewContentModeRight:
					contentLabel.textAlignment = NSTextAlignmentRight;
					break;
				case UIViewContentModeCenter:
					contentLabel.textAlignment = NSTextAlignmentCenter;
					break;
				case UIViewContentModeScaleAspectFill:
				case UIViewContentModeScaleAspectFit:
					contentLabel.textAlignment = NSTextAlignmentJustified;
					break;
			}
			
			contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
			contentLabel.tag = kContentTableLabelTag;
			contentLabel.numberOfLines = 0;
			[stringCell.contentView addSubview:contentLabel];
			
			NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:self.itemCellInsets.left];
			NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:self.itemCellInsets.top];
			NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-self.itemCellInsets.right];
			NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.itemCellInsets.bottom];
			[stringCell.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
		}
		
		
		UILabel *contentLabel = (UILabel *)[stringCell viewWithTag:kContentTableLabelTag];
		contentLabel.attributedText = [[NSAttributedString alloc] initWithString:stringItem attributes:self.itemCellTextAttributes];
		
		return stringCell;
	}
	
	else if ([item isKindOfClass:[NSArray class]]) {
		NSArray *arrayItem = (NSArray *)item;
		
		NSMutableString *completeString = [NSMutableString stringWithString:[arrayItem firstObject]];
		for (int i = 1; i < arrayItem.count; i++) {
			[completeString appendString:@"\n"];
			[completeString appendString:arrayItem[i]];
		}
		
		UITableViewCell *stringCell = [tableView dequeueReusableCellWithIdentifier:kContentTableStringIdentifier];
		if (!stringCell) {
			stringCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentTableStringIdentifier];
			stringCell.backgroundColor = [UIColor clearColor];
			stringCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;

			UILabel *contentLabel = [[UILabel alloc] init];
			contentLabel.backgroundColor = [UIColor clearColor];
			contentLabel.contentMode = self.itemCellContentMode;
			
			switch (self.itemCellContentMode) {
				default:
				case UIViewContentModeLeft:
					contentLabel.textAlignment = NSTextAlignmentLeft;
					break;
				case UIViewContentModeRight:
					contentLabel.textAlignment = NSTextAlignmentRight;
					break;
				case UIViewContentModeCenter:
					contentLabel.textAlignment = NSTextAlignmentCenter;
					break;
				case UIViewContentModeScaleAspectFill:
				case UIViewContentModeScaleAspectFit:
					contentLabel.textAlignment = NSTextAlignmentJustified;
					break;
			}
			
			contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
			contentLabel.tag = kContentTableLabelTag;
			contentLabel.numberOfLines = 0;
			[stringCell.contentView addSubview:contentLabel];
			
			NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:self.itemCellInsets.left];
			NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:self.itemCellInsets.top];
			NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-self.itemCellInsets.right];
			NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:stringCell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.itemCellInsets.bottom];
			[stringCell.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
		}
		
		
		UILabel *contentLabel = (UILabel *)[stringCell viewWithTag:kContentTableLabelTag];
		contentLabel.attributedText = [[NSAttributedString alloc] initWithString:completeString attributes:self.itemCellTextAttributes];
		
		return stringCell;
	}
	
	else if ([item isKindOfClass:[UIImage class]]) {
		UIImage *imageItem = (UIImage *)item;
		
		UITableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kContentTableImageIdentifier];
		if (!imageCell) {
			imageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentTableImageIdentifier];
			imageCell.backgroundColor = [UIColor clearColor];
			imageCell.selectionStyle = self.contentDelegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
			
			UIImageView *contentImageView = [[UIImageView alloc] init];
			contentImageView.translatesAutoresizingMaskIntoConstraints = NO;
			contentImageView.contentMode = self.itemCellContentMode;
			contentImageView.tag = kCOntentTableImageViewTag;
			[imageCell.contentView addSubview:contentImageView];
			
			NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:contentImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageCell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:self.itemCellInsets.left];
			NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:contentImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageCell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:self.itemCellInsets.top];
			NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:contentImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageCell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-self.itemCellInsets.right];
			NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:contentImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageCell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.itemCellInsets.bottom];
			[imageCell.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
		}
		
		UIImageView *contentImageView = (UIImageView *)[imageCell viewWithTag:kCOntentTableImageViewTag];
		contentImageView.image = imageItem;
		
		return imageCell;
	}
	
    return nil;
}
							 
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.contentView.backgroundColor = self.itemCellBackgroundColor;
	
	/*// Special thanks to http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsMake(0, self.itemCellInsets.left, 0, self.itemCellInsets.right)];
	}
	
	// Prevent the cell from inheriting the Table View's margin settings
	if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
		[cell setPreservesSuperviewLayoutMargins:NO];
	}
	
	// Explictly set your cell's layout margins
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsMake(0, self.itemCellInsets.left, 0, self.itemCellInsets.right)];
	}*/
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (self.contentDelegate) {
		NSInteger itemIndex = self.tableView.style == UITableViewStylePlain ? indexPath.row : indexPath.section;
		[self.contentDelegate contentTableViewController:self didTapItem:self.items[itemIndex]];
	}
}
							 
@end
