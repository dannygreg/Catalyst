//*******************************************************************************

// Copyright (c) 2009 Danny Greg

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// Created by Danny Greg on 11/12/2009

//*******************************************************************************

#import "CTAppController.h"
#import "CTBrowserWindowController.h"

#import "NSUserDefaults+CTExtensions.h"

NSString *CTStatusItemEnabledDefaultsKey = @"CTStatusItemEnabled";

@interface CTAppController ()

@property CTBrowserWindowController *browserWindowController;
@property NSStatusItem *statusItem;

@end

@implementation CTAppController
@synthesize browserWindowController = _browserWindowController, statusItem = _statusItem;

- (void)awakeFromNib
{
	self.browserWindowController = [[CTBrowserWindowController alloc] initWithWindowNibName:@"BrowserWindow"];
	[self.browserWindowController showWindow:self];
	if ([[[NSUserDefaults standardUserDefaults] objectForInfoDictionaryKey:CTStatusItemEnabledDefaultsKey] boolValue])
		[self attachStatusItem];
}

- (void)showHideBrowserWindow
{
	if ([[self.browserWindowController window] isVisible]) {
		[self.browserWindowController close];
	} else {
		[NSApp activateIgnoringOtherApps:YES];
		[self.browserWindowController showWindow:self];
	}
}

#pragma mark -
#pragma mark Status Item

- (void)attachStatusItem
{
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	NSImage *icon = [NSApp applicationIconImage];
	[icon setSize:NSMakeSize(20.0, 20.0)];
	[self.statusItem setImage:icon];
	[self.statusItem setAction:@selector(showHideBrowserWindow)];
	[self.statusItem setTarget:self];
	[self.statusItem setHighlightMode:YES];
}

@end
