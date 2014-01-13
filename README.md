![XHTumblrMenu] (https://github.com/JackTeam/XHTumblrMenu/raw/master//creensots/XHTumblrMenu.gif)


XHTumblrMenu
============

Tumblr iOS app like menu view.

Completely created using core animation.

Easy to drop into your project.

You can add as many items as you want, the XHTumblrMenu will layout them automatically.


## Requirements ##

XHTumblrMenu requires Xcode 5, targeting either iOS 5.0 and above, ARC-enabled.

## Installation

CocoaPods is the recommended method of installing XHTumblrMenu, just add the following line to your Podfile:

Podfile
```ruby
pod 'XHTumblrMenu'
```

## How to use ##
	
Drag XHTumblrMenu.h amd XHTumblrMenu.m files to your project. 

No other frameworks required.

```objective-c
#import "XHTumblrMenu.h"

XHTumblrMenu *tumblrMenu = [[XHTumblrMenu alloc] init];
XHTumblrMenuItem *tumblrMenuItem = [[XHTumblrMenuItem alloc] init];
tumblrMenuItem.title = @"title";
tumblrMenuItem.iconImage = [UIImage imageNamed:@"title.png"];
tumblrMenuItem.tumblrMenuViewSelectedBlock = ^(XHTumblrMenu *tumblrMenu, XHTumblrMenuItem *tumblrMenuItem) {
            NSLog(@"title : %@", tumblrMenuItem.title);
};
[tumblrMenu addMenuItemWithTumblrMenuItem:tumblrMenuItem];
[tumblrMenu show];
```

## Lincense ##

XHTumblrMenu is available under the MIT license. See the LICENSE file for more info.

