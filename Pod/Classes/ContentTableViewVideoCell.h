//
//  ContentTableViewVideoCell.h
//  Pods
//
//  Created by Julian Weiss on 2/9/16.
//
//

#import "ContentTableViewCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ContentTableViewVideoCell : ContentTableViewCell

@property (strong, nonatomic) NSURL *displayVideoURL;

@property (strong, nonatomic) AVPlayerViewController *contentViewController;

@end
