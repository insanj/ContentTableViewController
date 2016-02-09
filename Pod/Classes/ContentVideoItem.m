//
//  ContentVideoItem.m
//  Pods
//
//  Created by Julian Weiss on 2/9/16.
//
//

#import "ContentVideoItem.h"

@implementation ContentVideoItem

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _videoCellHeight = 200.0;
    }
    
    return self;
}

+ (instancetype)itemWithURL:(NSURL *)url {
    ContentVideoItem *item = [[ContentVideoItem alloc] init];
    item.videoURL = url;
    return item;
}

@end
