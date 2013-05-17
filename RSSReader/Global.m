//
//  Global.m
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-15.
//  Copyright (c) 2013年 Xie Smeegol. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (NSRect)screenResolution
{
    NSRect screenRect;
    for (NSScreen *screen in [NSScreen screens]) {
        screenRect = [screen visibleFrame];
		NSLog(@"%.1fx%.1f", screenRect.size.width, screenRect.size.height);
    }
    return screenRect;
}

@end
