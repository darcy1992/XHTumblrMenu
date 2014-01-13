//
//  XHTumblrMenu.m
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHTumblrMenu.h"
#import "XHTumblrMenuItemButton.h"

@interface XHTumblrMenu () {
    UIImageView *_backgroundView;
    NSMutableArray *_items;
}

@end

@implementation XHTumblrMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        ges.delegate = self;
        [self addGestureRecognizer:ges];
        self.backgroundColor = [UIColor clearColor];
        _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = XHTumblrBlue;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_backgroundView];
        _items = [[NSMutableArray alloc] initWithCapacity:6];
    }
    return self;
}

- (void)addMenuItemWithTumblrMenuItem:(XHTumblrMenuItem *)tumblrMenuItem {
    XHTumblrMenuItemButton *tumblrMenuItemButton = [[XHTumblrMenuItemButton alloc] initWithTumblrMenuItem:tumblrMenuItem];
    [tumblrMenuItemButton addTarget:self action:@selector(tumblrMenuItemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tumblrMenuItemButton];
    [_items addObject:tumblrMenuItemButton];
}

- (CGRect)frameForButtonAtIndex:(NSUInteger)index
{
    NSUInteger columnCount = 3;
    NSUInteger columnIndex =  index % columnCount;
    
    NSUInteger rowCount = _items.count / columnCount + (_items.count%columnCount>0?1:0);
    NSUInteger rowIndex = index / columnCount;
    
    CGFloat itemHeight = (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) * rowCount + (rowCount > 1?(rowCount - 1) * XHTumblrMenuViewHorizontalMargin:0);
    CGFloat offsetY = (self.bounds.size.height - itemHeight) / 2.0;
    CGFloat verticalPadding = (self.bounds.size.width - XHTumblrMenuViewHorizontalMargin * 2 - XHTumblrMenuViewImageHeight * 3) / 2.0;
    
    CGFloat offsetX = XHTumblrMenuViewHorizontalMargin;
    offsetX += (XHTumblrMenuViewImageHeight+ verticalPadding) * columnIndex;
    
    offsetY += (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight + XHTumblrMenuViewVerticalPadding) * rowIndex;
    
    
    return CGRectMake(offsetX, offsetY, XHTumblrMenuViewImageHeight, (XHTumblrMenuViewImageHeight+XHTumblrMenuViewTitleHeight));
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSUInteger i = 0; i < _items.count; i++) {
        XHTumblrMenuItemButton *button = _items[i];
        button.frame = [self frameForButtonAtIndex:i];
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:[XHTumblrMenuItemButton class]]) {
        return NO;
    }
    
    CGPoint location = [gestureRecognizer locationInView:self];
    for (UIView* subview in _items) {
        if (CGRectContainsPoint(subview.frame, location)) {
            return NO;
        }
    }
    
    return YES;
}

- (void)dismiss:(id)sender
{
    [self dropAnimation];
    double delayInSeconds = XHTumblrMenuViewAnimationTime  + XHTumblrMenuViewAnimationInterval * (_items.count + 1);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeFromSuperview];
    });
}


- (void)tumblrMenuItemButtonTapped:(XHTumblrMenuItemButton *)tumblrMenuItemButton
{
    [self dismiss:nil];
    
    __weak typeof(self) weakSelf = self;
    double delayInSeconds = XHTumblrMenuViewAnimationTime  + XHTumblrMenuViewAnimationInterval * (_items.count + 1);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        tumblrMenuItemButton.tumblrMenuItem.tumblrMenuViewSelectedBlock(weakSelf, tumblrMenuItemButton.tumblrMenuItem);
    });
}


- (void)riseAnimation {
    NSUInteger columnCount = 3;
    NSUInteger rowCount = _items.count / columnCount + (_items.count%columnCount>0?1:0);
    
    
    for (NSUInteger index = 0; index < _items.count; index++) {
        XHTumblrMenuItemButton *button = _items[index];
        button.layer.opacity = 0;
        CGRect frame = [self frameForButtonAtIndex:index];
        NSUInteger rowIndex = index / columnCount;
        NSUInteger columnIndex = index % columnCount;
        CGPoint fromPosition = CGPointMake(frame.origin.x + XHTumblrMenuViewImageHeight / 2.0,frame.origin.y +  (rowCount - rowIndex + 2)*200 + (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) / 2.0);
        
        CGPoint toPosition = CGPointMake(frame.origin.x + XHTumblrMenuViewImageHeight / 2.0,frame.origin.y + (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) / 2.0);
        
        double delayInSeconds = rowIndex * columnCount * XHTumblrMenuViewAnimationInterval;
        if (!columnIndex) {
            delayInSeconds += XHTumblrMenuViewAnimationInterval;
        } else if(columnIndex == 2) {
            delayInSeconds += XHTumblrMenuViewAnimationInterval * 2;
        }
        
        CABasicAnimation *positionAnimation;
        
        positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.45f :1.2f :0.75f :1.0f];
        positionAnimation.duration = XHTumblrMenuViewAnimationTime;
        positionAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayInSeconds;
        [positionAnimation setValue:[NSNumber numberWithUnsignedInteger:index] forKey:XHTumblrMenuViewRriseAnimationID];
        positionAnimation.delegate = self;
        
        [button.layer addAnimation:positionAnimation forKey:@"riseAnimation"];
    }
}

- (void)dropAnimation {
    NSUInteger columnCount = 3;
    for (NSUInteger index = 0; index < _items.count; index++) {
        XHTumblrMenuItemButton *button = _items[index];
        CGRect frame = [self frameForButtonAtIndex:index];
        NSUInteger rowIndex = index / columnCount;
        NSUInteger columnIndex = index % columnCount;
        
        CGPoint toPosition = CGPointMake(frame.origin.x + XHTumblrMenuViewImageHeight / 2.0,frame.origin.y -  (rowIndex + 2)*200 + (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) / 2.0);
        
        CGPoint fromPosition = CGPointMake(frame.origin.x + XHTumblrMenuViewImageHeight / 2.0,frame.origin.y + (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) / 2.0);
        
        double delayInSeconds = rowIndex * columnCount * XHTumblrMenuViewAnimationInterval;
        if (!columnIndex) {
            delayInSeconds += XHTumblrMenuViewAnimationInterval;
        } else if(columnIndex == 2) {
            delayInSeconds += XHTumblrMenuViewAnimationInterval * 2;
        }
        CABasicAnimation *positionAnimation;
        
        positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.3 :0.5f :1.0f :1.0f];
        positionAnimation.duration = XHTumblrMenuViewAnimationTime;
        positionAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayInSeconds;
        [positionAnimation setValue:[NSNumber numberWithUnsignedInteger:index] forKey:XHTumblrMenuViewDismissAnimationID];
        positionAnimation.delegate = self;
        
        [button.layer addAnimation:positionAnimation forKey:@"riseAnimation"];
    }
    
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSUInteger columnCount = 3;
    if([anim valueForKey:XHTumblrMenuViewRriseAnimationID]) {
        NSUInteger index = [[anim valueForKey:XHTumblrMenuViewRriseAnimationID] unsignedIntegerValue];
        UIView *view = _items[index];
        CGRect frame = [self frameForButtonAtIndex:index];
        CGPoint toPosition = CGPointMake(frame.origin.x + XHTumblrMenuViewImageHeight / 2.0,frame.origin.y + (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) / 2.0);
        CGFloat toAlpha = 1.0;
        
        view.layer.position = toPosition;
        view.layer.opacity = toAlpha;
        
    } else if([anim valueForKey:XHTumblrMenuViewDismissAnimationID]) {
        NSUInteger index = [[anim valueForKey:XHTumblrMenuViewDismissAnimationID] unsignedIntegerValue];
        NSUInteger rowIndex = index / columnCount;
        
        UIView *view = _items[index];
        CGRect frame = [self frameForButtonAtIndex:index];
        CGPoint toPosition = CGPointMake(frame.origin.x + XHTumblrMenuViewImageHeight / 2.0,frame.origin.y -  (rowIndex + 2)*200 + (XHTumblrMenuViewImageHeight + XHTumblrMenuViewTitleHeight) / 2.0);
        
        view.layer.position = toPosition;
    }
}

- (void)show {
    
    UIViewController *appRootViewController;
    UIWindow *window;
    
    window = [UIApplication sharedApplication].keyWindow;
    
    
    appRootViewController = window.rootViewController;
    
    
    
    UIViewController *topViewController = appRootViewController;
    while (topViewController.presentedViewController != nil) {
        topViewController = topViewController.presentedViewController;
    }
    
    if ([topViewController.view viewWithTag:XHTumblrMenuViewTag]) {
        [[topViewController.view viewWithTag:XHTumblrMenuViewTag] removeFromSuperview];
    }
    
    self.frame = topViewController.view.bounds;
    [topViewController.view addSubview:self];
    
    [self riseAnimation];
}

@end
