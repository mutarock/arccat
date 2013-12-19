//
//  AppDelegate.m
//  TestOSXApp
//
//  Created by ssukcha on 2013. 12. 19..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "AppDelegate.h"
#import "UnitTestUI.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [UnitTest run:self];
}

@end
