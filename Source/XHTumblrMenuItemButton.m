//
//  XHTumblrMenuItemButton.m
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHTumblrMenuItemButton.h"

@interface XHTumblrMenuItemButton () {
    UIImageView *iconView_;
    UILabel *titleLabel_;
}

@end

@implementation XHTumblrMenuItemButton

- (id)initWithTumblrMenuItem:(XHTumblrMenuItem *)tumblrMenuItem {
    self = [super init];
    if (self) {
        iconView_ = [UIImageView new];
        iconView_.image = tumblrMenuItem.icon;
        titleLabel_ = [UILabel new];
        titleLabel_.textAlignment = NSTextAlignmentCenter;
        titleLabel_.backgroundColor = [UIColor clearColor];
        titleLabel_.textColor = [UIColor whiteColor];
        titleLabel_.text = tumblrMenuItem.title;
        _selectedBlock = tumblrMenuItem.tumblrMenuViewSelectedBlock;
        [self addSubview:iconView_];
        [self addSubview:titleLabel_];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    iconView_.frame = CGRectMake(0, 0, XHTumblrMenuViewImageHeight, XHTumblrMenuViewImageHeight);
    titleLabel_.frame = CGRectMake(0, XHTumblrMenuViewImageHeight, XHTumblrMenuViewImageHeight, XHTumblrMenuViewTitleHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
