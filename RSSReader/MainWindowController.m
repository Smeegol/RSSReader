//
//  MainWindowController.m
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-19.
//  Copyright (c) 2013年 Yiyacare. All rights reserved.
//

#import "MainWindowController.h"
#import "Global.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
	
	NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_articleWebView.mainFrame loadRequest:request];
    
	/*rootsArray = [[NSArray alloc] initWithObjects:@"主页", @"所有条目", @"加星标的条目", @"趋势", @"订阅", nil];
	 foldersDict = [[NSDictionary alloc] initWithObjectsAndKeys:
	 [NSArray arrayWithObjects:@"Blog", @"cnBeta", @"Cute", nil], @"订阅", nil];
	 itemsDict = [[NSDictionary alloc] initWithObjectsAndKeys:
	 [NSMutableArray arrayWithObjects:@"无名小卒", nil], @"Blog",
	 [NSArray arrayWithObjects:@"cnBeta.COM", nil], @"cnBeta",
	 [NSArray arrayWithObjects:@"果壳网", @"萝卜网", nil], @"Cute", nil];*/
	
	
	rootItems = [[NSMutableArray alloc] init];
	
	SourceListItem *homeItem = [SourceListItem itemWithTitle:@"主页" identifier:@"library"];
	SourceListItem *allItem = [SourceListItem itemWithTitle:@"所有条目" identifier:@"music"];
	SourceListItem *staredItem = [SourceListItem itemWithTitle:@"加星标的条目" identifier:@"movies"];
	SourceListItem *trendItem = [SourceListItem itemWithTitle:@"趋势" identifier:@"podcasts"];
	SourceListItem *settingsItem = [SourceListItem itemWithTitle:@"设置" identifier:@"audiobooks"];
	[allItem setBadgeValue:54];
	[staredItem setBadgeValue:0];
	[homeItem setChildren:[NSArray arrayWithObjects:allItem, staredItem, trendItem, settingsItem, nil]];
	
	NSImage *folderIcon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)];
	NSImage *fileIcon = [[NSWorkspace sharedWorkspace] iconForFileType:@".txt"];
	
	SourceListItem *playlistsItem = [SourceListItem itemWithTitle:@"订阅" identifier:@"playlists"];
	
	SourceListItem *playlistGroup1 = [SourceListItem itemWithTitle:@"Blog" identifier:@"playlistgroup1"];
	SourceListItem *playlistItem1_1 = [SourceListItem itemWithTitle:@"无名小卒" identifier:@"playlist1_1"];
	[playlistItem1_1 setIcon:[NSImage imageNamed:@"playlist.png"]];
	[playlistGroup1 setChildren:[NSArray arrayWithObjects:playlistItem1_1, nil]];
	
	SourceListItem *playlistGroup2 = [SourceListItem itemWithTitle:@"cnBeta" identifier:@"playlistgroup2"];
	[playlistGroup2 setBadgeValue:54];
	SourceListItem *playlistItem2_1 = [SourceListItem itemWithTitle:@"cnBeta.COM" identifier:@"playlist2_1"];
	[playlistItem2_1 setIcon:[NSImage imageNamed:@"playlist.png"]];
	[playlistItem2_1 setBadgeValue:54];
	[playlistGroup2 setChildren:[NSArray arrayWithObjects:playlistItem2_1, nil]];
	
	SourceListItem *playlistGroup3 = [SourceListItem itemWithTitle:@"Cute" identifier:@"playlistgroup3"];
	SourceListItem *playlistItem3_1 = [SourceListItem itemWithTitle:@"果壳网" identifier:@"playlist3_1"];
	SourceListItem *playlistItem3_2 = [SourceListItem itemWithTitle:@"萝卜网" identifier:@"playlist3_2"];
	[playlistItem3_1 setIcon:[NSImage imageNamed:@"playlist.png"]];
	[playlistItem3_2 setIcon:[NSImage imageNamed:@"playlist.png"]];
	
	[playlistGroup3 setChildren:[NSArray arrayWithObjects:playlistItem3_1, playlistItem3_2, nil]];
	
	SourceListItem *playlistItem4 = [SourceListItem itemWithTitle:@"Smeegol.COM" identifier:@"playlist4"];
	[playlistItem4 setIcon:[NSImage imageNamed:@"playlist.png"]];
	
	[playlistGroup1 setIcon:folderIcon];
	[playlistGroup2 setIcon:folderIcon];
	[playlistGroup3 setIcon:folderIcon];
	[playlistItem1_1 setIcon:fileIcon];
	[playlistItem2_1 setIcon:fileIcon];
	[playlistItem3_1 setIcon:fileIcon];
	[playlistItem3_2 setIcon:fileIcon];
	[playlistItem4 setIcon:fileIcon];
	
	[playlistsItem setChildren:[NSArray arrayWithObjects:playlistGroup1, playlistGroup2, playlistGroup3,
								playlistItem4, nil]];
	
	[rootItems addObject:homeItem];
	[rootItems addObject:playlistsItem];
	
	[_sourceList reloadData];
	
	articlesArray = [[NSArray alloc] initWithObjects:@"AAA", @"BBB", nil];
	[_itemsTableView reloadData];
	
	NSRect frame = self.window.frame;
	frame.size = [Global screenResolution].size;
	[self.window setFrame:frame display:YES animate:YES];
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)subview
{
	/*if (splitView == _outerSplitView) {
	 return YES;
	 }*/
	return NO;
}

#pragma mark - Source List Data Source Methods

- (NSUInteger)sourceList:(PXSourceList*)sourceList numberOfChildrenOfItem:(id)item
{
	if (item == nil) {
		return [rootItems count];
	} else {
		return [[item children] count];
	}
}

- (id)sourceList:(PXSourceList*)aSourceList child:(NSUInteger)index ofItem:(id)item
{
	if (item == nil) {
		return [rootItems objectAtIndex:index];
	} else {
		return [[item children] objectAtIndex:index];
	}
}

- (id)sourceList:(PXSourceList*)aSourceList objectValueForItem:(id)item
{
	return [item title];
}

- (void)sourceList:(PXSourceList*)aSourceList setObjectValue:(id)object forItem:(id)item
{
	[item setTitle:object];
}

- (BOOL)sourceList:(PXSourceList*)aSourceList isItemExpandable:(id)item
{
	return [item hasChildren];
}

- (BOOL)sourceList:(PXSourceList*)aSourceList itemHasBadge:(id)item
{
	return [item hasBadge];
}

- (NSInteger)sourceList:(PXSourceList*)aSourceList badgeValueForItem:(id)item
{
	return [item badgeValue];
}

- (BOOL)sourceList:(PXSourceList*)aSourceList itemHasIcon:(id)item
{
	return [item hasIcon];
}

- (NSImage*)sourceList:(PXSourceList*)aSourceList iconForItem:(id)item
{
	return [item icon];
}

- (NSMenu*)sourceList:(PXSourceList*)aSourceList menuForEvent:(NSEvent*)theEvent item:(id)item
{
	if ([theEvent type] == NSRightMouseDown || ([theEvent type] == NSLeftMouseDown && ([theEvent modifierFlags] & NSControlKeyMask) == NSControlKeyMask)) {
		NSMenu * m = [[NSMenu alloc] init];
		if (item != nil) {
			[m addItemWithTitle:[item title] action:nil keyEquivalent:@""];
		} else {
			[m addItemWithTitle:@"clicked outside" action:nil keyEquivalent:@""];
		}
		return m;
	}
	return nil;
}

#pragma mark - Source List Delegate Methods

- (BOOL)sourceList:(PXSourceList*)aSourceList isGroupAlwaysExpanded:(id)group
{
	/*if([[group identifier] isEqualToString:@"library"])
	 return YES;
	 
	 return NO;*/
	
	return YES;
}


- (void)sourceListSelectionDidChange:(NSNotification *)notification
{
	/*NSIndexSet *selectedIndexes = [sourceList selectedRowIndexes];
	 
	 //Set the label text to represent the new selection
	 if([selectedIndexes count]>1)
	 [selectedItemLabel setStringValue:@"(multiple)"];
	 else if([selectedIndexes count]==1) {
	 NSString *identifier = [[sourceList itemAtRow:[selectedIndexes firstIndex]] identifier];
	 
	 [selectedItemLabel setStringValue:identifier];
	 }
	 else {
	 [selectedItemLabel setStringValue:@"(none)"];
	 }*/
}


- (void)sourceListDeleteKeyPressedOnRows:(NSNotification *)notification
{
	NSIndexSet *rows = [[notification userInfo] objectForKey:@"rows"];
	NSLog(@"Delete key pressed on rows %@", rows);
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return [articlesArray count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	return [articlesArray objectAtIndex:row];
}

@end
