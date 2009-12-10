//
//  CatalystAppDelegate.h
//  Catalyst
//
//  Created by Danny Greg on 10/12/2009.
//  Copyright 2009 Realmac Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CatalystAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
