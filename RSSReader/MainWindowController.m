//
//  MainWindowController.m
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-19.
//  Copyright (c) 2013年 Yiyacare. All rights reserved.
//

#import "MainWindowController.h"
#import "Global.h"
#import "Folder.h"
#import "Channel.h"
#import "Article.h"

#define ITEM_HOME		@"ItemHome"
#define ITEM_ALL		@"ItemAll"
#define ITEM_STARRED	@"ItemStarred"
#define ITEM_TRENDS		@"ItemTrends"
#define ITEM_SETUP		@"ItemSetup"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)theWindow
{
    self = [super initWithWindow:theWindow];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
	
	//[self setupCustomWindow];
	
	rootsArray = [[NSMutableArray alloc] init];
	
	SourceListItem *homeItem = [SourceListItem itemWithTitle:@"主页" identifier:ITEM_HOME];
	SourceListItem *allItem = [SourceListItem itemWithTitle:@"所有条目" identifier:ITEM_ALL];
	SourceListItem *starredItem = [SourceListItem itemWithTitle:@"加星标的条目" identifier:ITEM_STARRED];
	SourceListItem *trendsItem = [SourceListItem itemWithTitle:@"趋势" identifier:ITEM_TRENDS];
	SourceListItem *setupItem = [SourceListItem itemWithTitle:@"设置" identifier:ITEM_SETUP];
	[allItem setBadgeValue:54];
	[starredItem setBadgeValue:0];
	[homeItem setChildren:[NSArray arrayWithObjects:allItem, starredItem, trendsItem, setupItem, nil]];
	[rootsArray addObject:homeItem];
	
	[self initFoldersArray];
	[self initChannelsDictionary];
	
	NSImage *folderImage = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)];
	NSImage *channelImage = [NSImage imageNamed:@"FeedDefaultIcon"];
	
	SourceListItem *subscriptionsItem = [SourceListItem itemWithTitle:@"订阅" identifier:@"playlists"];
	
	NSMutableArray *folderItemsArray = [[NSMutableArray alloc] init];
	for (Folder *folder in foldersArray) {
		SourceListItem *folderItem = [SourceListItem itemWithTitle:folder.title identifier:[NSString stringWithFormat:@"folder_%d", folder.ID]];
		[folderItem setIcon:folderImage];
		[folderItemsArray addObject:folderItem];
		
		NSMutableArray *channelItemsArray = [[NSMutableArray alloc] init];
		NSArray *channelsArray = [channelsDict objectForKey:[NSString stringWithFormat:@"%d", folder.ID]];
		for (Channel *channel in channelsArray) {
			SourceListItem *channelItem = [SourceListItem itemWithTitle:channel.title identifier:[NSString stringWithFormat:@"channel_%d", channel.ID]];
			[channelItem setIcon:channelImage];
			[channelItemsArray addObject:channelItem];
		}
		[folderItem setChildren:channelItemsArray];
	}
	
	NSArray *unfoldedChannelsArray = [channelsDict objectForKey:@"-1"];
	for (Channel *channel in unfoldedChannelsArray) {
		SourceListItem *channelItem = [SourceListItem itemWithTitle:channel.title identifier:[NSString stringWithFormat:@"channel_%d", channel.ID]];
		[channelItem setIcon:channelImage];
		[folderItemsArray addObject:channelItem];
	}
	
	[subscriptionsItem setChildren:folderItemsArray];
	
	[rootsArray addObject:subscriptionsItem];
	[_sourceList reloadData];
	
	[_sourceList expandItem:subscriptionsItem expandChildren:YES];
	
	[self initArticlesArray];
	[_itemsTableView reloadData];
	
	NSRect frame = self.window.frame;
	frame.size = [Global screenResolution].size;
	[self.window setFrame:frame display:YES animate:YES];
	
	NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_articleWebView.mainFrame loadRequest:request];
}

- (void)initFoldersArray
{
	foldersArray = [[NSMutableArray alloc] init];
	
	Folder *folder1 = [[Folder alloc] init];
	folder1.ID = 1;
	folder1.title = @"Blog";
	[foldersArray addObject:folder1];
	
	Folder *folder2 = [[Folder alloc] init];
	folder2.ID = 2;
	folder2.title = @"cnBeta";
	[foldersArray addObject:folder2];
	
	Folder *folder3 = [[Folder alloc] init];
	folder3.ID = 3;
	folder3.title = @"Cute";
	[foldersArray addObject:folder3];
}

- (void)initChannelsDictionary
{
	channelsDict = [[NSMutableDictionary alloc] init];
	
	Channel *channel1 = [[Channel alloc] init];
	channel1.ID = 1;
	channel1.folderID = 1;
	channel1.title = @"无名小卒";
	
	[channelsDict setObject:[NSMutableArray arrayWithObjects:channel1, nil] forKey:@"1"];
	
	Channel *channel2 = [[Channel alloc] init];
	channel2.ID = 2;
	channel2.folderID = 2;
	channel2.title = @"cnBeta.COM";
	
	[channelsDict setObject:[NSMutableArray arrayWithObjects:channel2, nil] forKey:@"2"];
	
	Channel *channel3 = [[Channel alloc] init];
	channel3.ID = 3;
	channel3.folderID = 3;
	channel3.title = @"果壳网";
	
	Channel *channel4 = [[Channel alloc] init];
	channel4.ID = 4;
	channel4.folderID = 3;
	channel4.title = @"萝卜网";
	
	[channelsDict setObject:[NSMutableArray arrayWithObjects:channel3, channel4, nil] forKey:@"3"];
	
	Channel *channel5 = [[Channel alloc] init];
	channel5.ID = 5;
	channel5.folderID = -1;
	channel5.title = @"Smeegol.COM";
	
	[channelsDict setObject:[NSMutableArray arrayWithObjects:channel5, nil] forKey:@"-1"];
}

- (void)initArticlesArray
{
	articlesArray = [[NSMutableArray alloc] init];
	
	Article *article1 = [[Article alloc] init];
	article1.channelID = 1;
	article1.title = @"“C++的数组不支持多态”？";
	article1.pubDate = @"04-28 16:17";
	[articlesArray addObject:article1];
	
	Article *article2 = [[Article alloc] init];
	article2.channelID = 2;
	article2.title = @"Unix考古记：一个“遗失”的shell";
	article2.pubDate = @"04-27 00:29";
	[articlesArray addObject:article2];
}

/*- (void)setupCustomWindow
{
	window = (INAppStoreWindow *)self.window;
	
	window.trafficLightButtonsLeftMargin = 7.0;
	window.fullScreenButtonRightMargin = 7.0;
	window.centerFullScreenButton = YES;
	window.titleBarHeight = 40.0;
	window.showsTitle = NO;
	
	[self setupCloseButton];
	[self setupMinimizeButton];
	[self setupZoomButton];
	
	//[window setContentBorderThickness:24.0 forEdge:NSMinYEdge];
}

- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    window.closeButton = closeButton;
}

- (void)setupMinimizeButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    window.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    window.zoomButton = button;
}*/

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
		return [rootsArray count];
	} else {
		return [[item children] count];
	}
}

- (id)sourceList:(PXSourceList*)aSourceList child:(NSUInteger)index ofItem:(id)item
{
	if (item == nil) {
		return [rootsArray objectAtIndex:index];
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
		NSMenu *menu = [[NSMenu alloc] init];
		if (item != nil && [[item identifier] hasPrefix:@"folder"]) {
			[menu addItemWithTitle:@"重命名文件夹" action:nil keyEquivalent:@""];
			[menu addItemWithTitle:@"删除文件夹" action:nil keyEquivalent:@""];
			[menu addItemWithTitle:@"取消所有订阅" action:nil keyEquivalent:@""];
		} else if (item != nil && [[item identifier] hasPrefix:@"channel"]) {
			[menu addItemWithTitle:@"重命名订阅..." action:nil keyEquivalent:@""];
			[menu addItemWithTitle:@"取消订阅" action:nil keyEquivalent:@""];
			[menu addItemWithTitle:@"更改文件夹" action:nil keyEquivalent:@""];
		} else {
			[menu addItemWithTitle:@"添加订阅" action:nil keyEquivalent:@""];
		}
		return menu;
	}
	return nil;
}

#pragma mark - Source List Delegate Methods

- (BOOL)sourceList:(PXSourceList*)aSourceList isGroupAlwaysExpanded:(id)group
{
	if ([[group identifier] isEqualToString:ITEM_HOME]) {
		return YES;
	}
	return NO;
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
