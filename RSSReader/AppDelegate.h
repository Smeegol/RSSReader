//
//  AppDelegate.h
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-11.
//  Copyright (c) 2013年 Xie Smeegol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "PXSourceList/PXSourceList.h"
#import "SourceListItem.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate, NSTableViewDataSource, NSTableViewDelegate, NSSplitViewDelegate, PXSourceListDataSource, PXSourceListDelegate> {
	NSArray *rootsArray;
    NSDictionary *foldersDict;
    NSDictionary *itemsDict;
	
	IBOutlet PXSourceList *sourceList;
	NSMutableArray *sourceListItems;
}

@property (assign) IBOutlet NSWindow *window;
//@property (weak) IBOutlet NSSplitView *outerSplitView;
@property (weak) IBOutlet NSSplitView *innerSplitView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSTableView *itemsTableView;
@property (weak) IBOutlet WebView *articleWebView;

@end
