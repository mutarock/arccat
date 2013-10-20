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
        UIView* view = nil;
        if ([ui conformsToProtocol:@protocol(UIApplicationDelegate)]) {
            UIViewController* vc = [[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController];
            view = vc.view;
        } else if ([ui isKindOfClass:[UIWindow class]]) {
            UIViewController* vc = [[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController];
            view = vc.view;
        } else if ([ui isKindOfClass:[UIView class]]) {
            view = ui;
        } else if ([ui isKindOfClass:[UIViewController class]]) {
            view = ((UIViewController*)ui).view;
        }
        if (nil != view) {
                view.backgroundColor =
                    (0 == UnitTestManager.sharedInstance.failures) ?
                        [UIColor colorWithRed:0.13 green:0.63 blue:0.13 alpha:1] : [UIColor redColor];
        }
    }
}

@end
