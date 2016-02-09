//
//  ContentTableViewVideoCell.m
//  Pods
//
//  Created by Julian Weiss on 2/9/16.
//
//

#import "ContentTableViewVideoCell.h"
#import "ContentTableViewController.h"

@interface ContentTableViewVideoCell ()

@end

@implementation ContentTableViewVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _contentViewController = [[AVPlayerViewController alloc] init];
        _contentViewController.showsPlaybackControls = NO;
        _contentViewController.view.opaque = YES;
        _contentViewController.view.backgroundColor = [UIColor clearColor];
        _contentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _contentViewController.view.userInteractionEnabled = NO;
        [self.contentView addSubview:_contentViewController.view];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [_contentViewController.player pause];
    _contentViewController.player = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setDisplayVideoURL:(NSURL *)displayVideoURL {
    _displayVideoURL = displayVideoURL;
    
    _contentViewController.player = [[AVPlayer alloc] initWithURL:_displayVideoURL];
    _contentViewController.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [_contentViewController.player play];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:_contentViewController.player.currentItem queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        AVPlayerItem *playerItem = note.object;
        [playerItem seekToTime:kCMTimeZero];
    }];
}

- (void)setParentController:(ContentTableViewController *)parentController {
    [super setParentController:parentController];
    
    UIView *videoView = _contentViewController.view;
    
    NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:videoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:parentController.itemCellInsets.left];
    NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:videoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:parentController.itemCellInsets.top];
    NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:videoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-parentController.itemCellInsets.right];
    NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:videoView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-parentController.itemCellInsets.bottom];
    [self.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
    
    [self.contentView updateConstraintsIfNeeded];
}

@end