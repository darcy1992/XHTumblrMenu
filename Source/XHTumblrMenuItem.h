//
//  XHTumblrMenuItem.h
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHTumblrMenuHeader.h"

@interface XHTumblrMenuItem : NSObject
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, copy) XHTumblrMenuViewSelectedBlock tumblrMenuViewSelectedBlock;
@end
