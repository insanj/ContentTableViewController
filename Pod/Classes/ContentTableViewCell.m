//
//  ContentTableViewCell.m
//  ContentTableViewCell
//
//  Created by Julian Weiss on 3/26/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import "ContentTableViewCell.h"

@interface ContentTableViewCell ()

@property (weak, nonatomic) ContentTableViewController *currentParentController;

@end

@implementation ContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.contentView.clipsToBounds = YES;
		
		self.contentTapButton = [[UIButton alloc] init];
		self.contentTapButton.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_contentTapButton];
		
		[self.contentView addConstraints:@[[NSLayoutConstraint constraintWithItem:_contentTapButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
										   [NSLayoutConstraint constraintWithItem:_contentTapButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0],
										   [NSLayoutConstraint constraintWithItem:_contentTapButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0],
										   [NSLayoutConstraint constraintWithItem:_contentTapButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0],]];
	}
	
	return self;
}


- (void)setParentController:(ContentTableViewController *)parentController {
	if (!_currentParentController || _currentParentController != parentController) {
		_currentParentController = parentController;
	}
	
	else {
		return;
	}
}

@end
