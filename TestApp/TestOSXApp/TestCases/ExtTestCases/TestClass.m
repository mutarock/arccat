//
//  TestClass.m
//  TestApp
//
//  Created by ssukcha on 2013. 12. 17..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "NSClassExt.h"
#import "UnitTest.h"

@interface TestClass : NSObject @end


@implementation TestClass

-(void) test_properties {
    assert_equal(@[@"-(void) test_properties ;"], [NSClassExt methodsForClass:TestClass.class]);

    NSArray* properties =@[
    ];
    assert_equal(properties, [NSClassExt propertiesForClass:NSTextView.class]);
}

@end
