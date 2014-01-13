//
//  XHTumblrMenuItemButton.m
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHTumblrMenuItemButton.h"

@interface XHTumblrMenuItemButton () {
    UIImageView *_iconView;
    UILabel *_titleLabel;
}

@end

@implementation XHTumblrMenuItemButton

- (id)initWithTumblrMenuItem:(XHTumblrMenuItem *)tumblrMenuItem {
    self = [super init];
    if (self) {
        _iconView = [UIImageView new];
        _iconView.image = tumblrMenuItem.iconImage;
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = tumblrMenuItem.title;
        self.tumblrMenuItem = tumblrMenuItem;
        [self addSubview:_iconView];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _iconView.frame = CGRectMake(0, 0, XHTumblrMenuViewImageHeight, XHTumblrMenuViewImageHeight);
    _titleLabel.frame = CGRectMake(0, XHTumblrMenuViewImageHeight, XHTumblrMenuViewImageHeight, XHTumblrMenuViewTitleHeight);
}

- (void)dealloc {
    _iconView = nil;
    _titleLabel = nil;
    
    self.tumblrMenuItem = nil;
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
