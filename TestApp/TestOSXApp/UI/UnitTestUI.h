//
//  UnitTestUI.h
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UnitTest.h"

@interface UnitTest (UI)

+(void) run:(id)ui ;
+(void) assertionsUp ;
+(void) failuresUp ;

@end
