//
//  ViewController.m
//  XHTumblrMenu
//
//  Created by 曾 宪华 on 14-1-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "ViewController.h"
#import "XHTumblrMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Show Menu" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0/2.0, 100, 48);
    button.center = self.view.center;
    [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showMenu {
    NSDictionary *tumblrMenuDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TumblrMenuList" ofType:@"plist"]];
    NSArray *tumblrMenuList = [tumblrMenuDictionary valueForKey:@"TumblrMenuList"];
    
    XHTumblrMenu *tumblrMenu = [[XHTumblrMenu alloc] init];
    for (NSDictionary *tumblrMenuDictionary in tumblrMenuList) {
        XHTumblrMenuItem *tumblrMenuItem = [[XHTumblrMenuItem alloc] init];
        tumblrMenuItem.title = [tumblrMenuDictionary valueForKey:@"title"];
        tumblrMenuItem.icon = [UIImage imageNamed:[tumblrMenuDictionary valueForKey:@"icon"]];
        tumblrMenuItem.tumblrMenuViewSelectedBlock = ^(XHTumblrMenu *tumblrMenu, XHTumblrMenuItem *tumblrMenuItem) {
            NSLog(@"title : %@", tumblrMenuItem.title);
        };
        [tumblrMenu addMenuItemWithTumblrMenuItem:tumblrMenuItem];
    }
    [tumblrMenu show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
