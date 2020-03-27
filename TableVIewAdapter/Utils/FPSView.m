//
//  FPSView.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/13.
//  Copyright © 2020 zz. All rights reserved.
//

#import "FPSView.h"

@implementation FPSView {
    CADisplayLink *_displayLink;
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getFPS:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.text = @"0 FPS";
        [self addSubview:_label];
    }
    return self;
}

- (void)getFPS:(CADisplayLink *)displayLink {
    NSInteger fps = (NSInteger)(1.0 / displayLink.duration);
    //NSLog(@"duration: %f, fps: %li", displayLink.duration, fps);
    _label.text = [NSString stringWithFormat:@"%li FPS", (long)fps];
}


@end
