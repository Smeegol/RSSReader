//
//  AppDelegate.m
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-11.
//  Copyright (c) 2013年 Xie Smeegol. All rights reserved.
//

#import "AppDelegate.h"
#import "Global.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_articleWebView.mainFrame loadRequest:request];
	
	NSRect frame = [_window frame];
	frame.size = [Global screenResolution].size;
	[_window setFrame:frame display:YES animate:YES];
}

- (void)awakeFromNib
{
	rootsArray = [[NSArray alloc] initWithObjects:@"主页", @"所有条目", @"加星标的条目", @"趋势", @"订阅", nil];
    foldersDict = [[NSDictionary alloc] initWithObjectsAndKeys:
				   [NSArray arrayWithObjects:@"Blog", @"cnBeta", @"Cute", nil], @"订阅", nil];
    itemsDict = [[NSDictionary alloc] initWithObjectsAndKeys:
				 [NSMutableArray arrayWithObjects:@"无名小卒", nil], @"Blog",
				 [NSArray arrayWithObjects:@"cnBeta.COM", nil], @"cnBeta",
				 [NSArray arrayWithObjects:@"果壳网", @"萝卜网", nil], @"Cute", nil];
    
    //[sideBar setRowSizeStyle:NSTableViewRowSizeStyleDefault];
    //[sideBar expandItem:nil expandChildren:YES];
    //[sideBar setFocusRingType: NSFocusRingTypeNone];
	
	
	sourceListItems = [[NSMutableArray alloc] init];
	
	SourceListItem *libraryItem = [SourceListItem itemWithTitle:@"主页" identifier:@"library"];
	SourceListItem *musicItem = [SourceListItem itemWithTitle:@"所有条目" identifier:@"music"];
	SourceListItem *moviesItem = [SourceListItem itemWithTitle:@"加星标的条目" identifier:@"movies"];
	SourceListItem *podcastsItem = [SourceListItem itemWithTitle:@"趋势" identifier:@"podcasts"];
	SourceListItem *audiobooksItem = [SourceListItem itemWithTitle:@"设置" identifier:@"audiobooks"];
	[musicItem setIcon:[NSImage imageNamed:@"music.png"]];
	[moviesItem setIcon:[NSImage imageNamed:@"movies.png"]];
	[podcastsItem setIcon:[NSImage imageNamed:@"podcasts.png"]];
	[audiobooksItem setIcon:[NSImage imageNamed:@"audiobooks.png"]];
	[musicItem setBadgeValue:54];
	[libraryItem setChildren:[NSArray arrayWithObjects:musicItem, moviesItem, podcastsItem,
							  audiobooksItem, nil]];
	
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
	
	[playlistsItem setChildren:[NSArray arrayWithObjects:playlistGroup1, playlistGroup2, playlistGroup3,
								playlistItem4, nil]];
	
	[sourceListItems addObject:libraryItem];
	[sourceListItems addObject:playlistsItem];
	
	[sourceList reloadData];
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)subview
{
	/*if (splitView == _outerSplitView) {
		return YES;
	}*/
	return NO;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

#pragma mark - Source List Data Source Methods

- (NSUInteger)sourceList:(PXSourceList*)sourceList numberOfChildrenOfItem:(id)item
{
	//Works the same way as the NSOutlineView data source: `nil` means a parent item
	if(item==nil) {
		return [sourceListItems count];
	}
	else {
		return [[item children] count];
	}
}

- (id)sourceList:(PXSourceList*)aSourceList child:(NSUInteger)index ofItem:(id)item
{
	//Works the same way as the NSOutlineView data source: `nil` means a parent item
	if(item==nil) {
		return [sourceListItems objectAtIndex:index];
	}
	else {
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
	
	//Do something here
}

/*#pragma mark - NSOutlineViewDatasource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [rootsArray count];
    } else if ([item isEqualToString:@"订阅"]) {
        return [[foldersDict objectForKey:item] count];
    } else {
        return [[itemsDict objectForKey:item] count];
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (item == nil) {
        return [rootsArray objectAtIndex: index];
    } else if ([item isEqualToString:@"订阅"]) {
        return [[foldersDict objectForKey:item] objectAtIndex:index];
    } else {
        return [[itemsDict objectForKey:item] objectAtIndex:index];
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	if ([item isEqualToString:@"订阅"]) {
        return YES;
    }
	for (NSString *folder in [foldersDict objectForKey:@"订阅"]) {
		if ([item isEqualToString:folder]) {
			return YES;
		}
	}
	return NO;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    if ([rootsArray containsObject:item]) {
        NSTableCellView *cellView = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
        [cellView.textField setStringValue:item];
        return cellView;
    } else {
        NSTableCellView *cellView = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
        [cellView.textField setStringValue:item];
        return cellView;
    }
}*/

#pragma mark - NSTableViewDatasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return 2;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	return @"aa";
}

@end
