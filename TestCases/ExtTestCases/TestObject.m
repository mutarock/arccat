//
//  TestObject.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSObjectExt.h"
#import "UnitTest.h"

@interface TestObject : NSObject @end


@implementation TestObject

+(void) class_method {
}

-(void) test_methods {
    NSArray* classMethods = [self classMethods];
    NSArray* methods = [self methods];

    assert_equal(@[@"+(void) class_method ;"], classMethods);
    assert_equal(@[@"-(void) test_methods ;"], methods);

}

@end
