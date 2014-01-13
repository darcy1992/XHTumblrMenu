//
//  XHTumblrMenuHeader.h
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#ifndef XHTumblrMenu_XHTumblrMenuHeader_h
#define XHTumblrMenu_XHTumblrMenuHeader_h

#define XHTumblrMenuViewTag 1999
#define XHTumblrMenuViewImageHeight 90
#define XHTumblrMenuViewTitleHeight 20
#define XHTumblrMenuViewVerticalPadding 10
#define XHTumblrMenuViewHorizontalMargin 10
#define XHTumblrMenuViewRriseAnimationID @"XHTumblrMenuViewRriseAnimationID"
#define XHTumblrMenuViewDismissAnimationID @"XHTumblrMenuViewDismissAnimationID"
#define XHTumblrMenuViewAnimationTime 0.37
#define XHTumblrMenuViewAnimationInterval (XHTumblrMenuViewAnimationTime / 5)

#define XHTumblrBlue [UIColor colorWithRed:0.019 green:0.215 blue:0.369 alpha:1.000]


@class XHTumblrMenu;
@class XHTumblrMenuItem;

typedef void (^XHTumblrMenuViewSelectedBlock)(XHTumblrMenu *tumblrMenu, XHTumblrMenuItem *tumblrMenuItem);

#endif
