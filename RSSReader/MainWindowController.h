//
//  MainWindowController.h
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-19.
//  Copyright (c) 2013年 Yiyacare. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "PXSourceList/PXSourceList.h"
#import "SourceListItem.h"
//#import "INAppStoreWindow.h"

@interface MainWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate, NSSplitViewDelegate, PXSourceListDataSource, PXSourceListDelegate> {
	NSMutableArray *rootsArray;
	NSMutableArray *foldersArray;
	NSMutableDictionary *channelsDict;
	NSMutableArray *articlesArray;
	
	//INAppStoreWindow *window;
}

@property (weak) IBOutlet PXSourceList *sourceList;
@property (weak) IBOutlet NSSplitView *innerSplitView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSTableView *itemsTableView;
@property (weak) IBOutlet WebView *articleWebView;

@end
