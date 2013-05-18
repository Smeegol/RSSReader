//
//  ArticleCell.h
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-18.
//  Copyright (c) 2013年 Yiyacare. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ArticleCell : NSTableCellView

@property (weak) IBOutlet NSTextField *folderLabel;
@property (weak) IBOutlet NSTextField *datetimeLabel;
@property (weak) IBOutlet NSTextField *titleLabel;

@end
