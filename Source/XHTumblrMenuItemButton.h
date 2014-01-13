//
//  XHTumblrMenuItemButton.h
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHTumblrMenuItem.h"

@interface XHTumblrMenuItemButton : UIControl
- (id)initWithTumblrMenuItem:(XHTumblrMenuItem *)tumblrMenuItem;
@property (nonatomic, strong) XHTumblrMenuItem *tumblrMenuItem;
@end
