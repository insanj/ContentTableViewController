//
//  ContentVideoItem.h
//  Pods
//
//  Created by Julian Weiss on 2/9/16.
//
//

#import <UIKit/UIKit.h>

@interface ContentVideoItem : NSObject

@property (strong, nonatomic) NSURL *videoURL;

@property (nonatomic, readwrite) CGFloat videoCellHeight;

+ (instancetype)itemWithURL:(NSURL *)url;

@end
