//
//  ContentTableViewImageCell.h
//  ContentTableViewImageCell
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import "ContentTableViewImageCell.h"
#import "ContentTableViewController.h"

@interface ContentTableViewImageCell ()

@property (strong, nonatomic) UIImageView *contentImageView;

@end

@implementation ContentTableViewImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {	
		self.contentImageView = [[UIImageView alloc] init];
		self.contentImageView.userInteractionEnabled = NO;
		self.contentImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:self.contentImageView];
	}
	
	return self;
}

- (UIImage *)displayImage {
	return self.contentImageView.image;
}

- (void)setDisplayImage:(UIImage *)displayImage {
	self.contentImageView.image = displayImage;
}

- (void)setParentController:(ContentTableViewController *)parentController {
	[super setParentController:parentController];
	self.contentImageView.contentMode = parentController.itemCellContentMode;

	NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:parentController.itemCellInsets.left];
	NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:parentController.itemCellInsets.top];
	NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-parentController.itemCellInsets.right];
	NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-parentController.itemCellInsets.bottom];
	[self.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
	
	[self.contentView updateConstraintsIfNeeded];
}

@end
