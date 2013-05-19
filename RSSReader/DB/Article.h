//
//  Article.h
//  RSSReader
//
//  Created by Xie Smeegol on 13-5-19.
//  Copyright (c) 2013年 Yiyacare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property int ID;
@property int channelID;
@property (strong) NSString *title;
@property (strong) NSString *link;
@property (strong) NSString *pubDate;
@property (strong) NSString *author;
@property (strong) NSString *description;
@property (strong) NSString *content;

@end
