# ContentTableViewController

[![Version](https://img.shields.io/cocoapods/v/ContentTableViewController.svg?style=flat)](http://cocoadocs.org/docsets/ContentTableViewController)
[![License](https://img.shields.io/cocoapods/l/ContentTableViewController.svg?style=flat)](http://cocoadocs.org/docsets/ContentTableViewController)
[![Platform](https://img.shields.io/cocoapods/p/ContentTableViewController.svg?style=flat)](http://cocoadocs.org/docsets/ContentTableViewController)

Super simple way to present content. A [ContentTableViewController](https://github.com/insanj/ContentTableViewController/blob/master/Pod/Classes/ContentTableViewController.h) can currently host `NSStrings`, `NSArrays` full of `NSStrings`, and `UIImages`. Documentation is provided Appledoc-style inline. 

![](example-empty.jpg)![](example-full.jpg)

## Usage

	ContentTableViewController *contentController = [[ContentTableViewController alloc] initWithItems:@[@"Hello", @"World"]];
	contentController.contentDelegate = self; // for interaction (contentTableViewController:didTapItem:)	

To see and run [the full example project](https://github.com/insanj/ContentTableViewController/blob/master/Example/ContentTableViewController/INSViewController.m
), clone the repo, and run `pod install` from the Example directory first.

## Installation

ContentTableViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ContentTableViewController"

## Author

[Julian (insanj) Weiss](https://twitter.com/insanj), [julian@urlinq.com](mailto:julian@urlinq.com)

## License

	ContentTableViewController: super simple way to present content.
	Copyright (C) 2015 Julian (insanj) Weiss
	
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.