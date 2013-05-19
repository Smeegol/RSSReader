//
//  Channel.h
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-19.
//  Copyright (c) 2013年 Yiyacare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property int ID;
@property int folderID;
@property (strong) NSString *title;
@property (strong) NSString *link;
@property (strong) NSString *description;

@end
