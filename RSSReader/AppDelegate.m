//
//  AppDelegate.m
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-11.
//  Copyright (c) 2013年 Xie Smeegol. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
	[_mainWindowController showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
