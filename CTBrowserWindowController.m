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

#import "CTBrowserWindowController.h"

#import "NSUserDefaults+CTExtensions.h"

#import <WebKit/WebKit.h>

NSString *const CTHomeLocationDefaultsKey = @"CTHomeLocation";

@interface CTBrowserWindowController ()

- (void)_showProgressView;
- (void)_hideProgressView;

@end

@implementation CTBrowserWindowController
@synthesize webView = _webView, progressView = _progressView;

- (void)awakeFromNib
{
	[self.progressView setAlphaValue:0.0];
	[self.webView setMainFrameURL:[[NSUserDefaults standardUserDefaults] objectForInfoDictionaryKey:CTHomeLocationDefaultsKey]];
}

#pragma mark -

- (void)_showProgressView
{
	[[self.window contentView] addSubview:self.progressView];
	[[self.progressView animator] setAlphaValue:1.0];
}

- (void)_hideProgressView
{
	[[self.progressView animator] setAlphaValue:0.0];
	[self.progressView removeFromSuperview];
}

#pragma mark -
#pragma mark WebFrame Load Delegates

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame
{
	[self.window setTitle:title];
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
	[self _showProgressView];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	[self _hideProgressView];
}

@end
