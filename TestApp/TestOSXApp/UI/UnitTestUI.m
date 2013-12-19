//
//  UnitTestUI.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTestUI.h"

@implementation UnitTest (UI)

+(void) run:(id)ui {
    [self run];
    if (UnitTestManager.sharedInstance.assertions > 0) {
        NSWindow* window = nil;
        if ([ui isKindOfClass:NSWindow.class]) {
            window = ui;
        } else if ([ui conformsToProtocol:@protocol(NSApplicationDelegate)]) {
            window = [ui window];
        }
        if (nil != window) {
            window.backgroundColor =
            (0 == UnitTestManager.sharedInstance.failures) ?
            [NSColor colorWithRed:0.13 green:0.63 blue:0.13 alpha:1] : [NSColor redColor];
        }
    }
}

+(void) assertionsUp {
    UnitTestManager.sharedInstance.assertions += 1;
}

+(void) failuresUp {
    UnitTestManager.sharedInstance.assertions += 1;
    UnitTestManager.sharedInstance.failures += 1;
}

@end