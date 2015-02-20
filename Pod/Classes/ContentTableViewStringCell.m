//
//  ContentTableViewStringCell.m
//  Pods
//
//  Created by Julian Weiss on 2/20/15.
//
//

#import "ContentTableViewStringCell.h"
#import "ContentTableViewController.h"

@interface ContentTableViewStringCell ()

@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation ContentTableViewStringCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		self.backgroundColor = [UIColor clearColor];

		self.contentLabel = [[UILabel alloc] init];
		self.contentLabel.backgroundColor = [UIColor clearColor];
		self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
		self.contentLabel.numberOfLines = 0;
		[self.contentView addSubview:self.contentLabel];
	}
	
	return self;
}

- (NSAttributedString *)displayString {
	return self.contentLabel.attributedText;
}

- (void)setDisplayString:(NSAttributedString *)displayString {
	self.contentLabel.attributedText = displayString;
}

- (void)setParentController:(ContentTableViewController *)parentController {
	self.contentLabel.contentMode = parentController.itemCellContentMode;

	switch (parentController.itemCellContentMode) {
		default:
		case UIViewContentModeLeft:
			self.contentLabel.textAlignment = NSTextAlignmentLeft;
			break;
		case UIViewContentModeRight:
			self.contentLabel.textAlignment = NSTextAlignmentRight;
			break;
		case UIViewContentModeCenter:
			self.contentLabel.textAlignment = NSTextAlignmentCenter;
			break;
		case UIViewContentModeScaleAspectFill:
		case UIViewContentModeScaleAspectFit:
			self.contentLabel.textAlignment = NSTextAlignmentJustified;
			break;
	}
	
	NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:parentController.itemCellInsets.left];
	NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:parentController.itemCellInsets.top];
	NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-parentController.itemCellInsets.right];
	NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-parentController.itemCellInsets.bottom];
	[self.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
}

@end
