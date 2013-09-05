//
//  TestString.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "NSStringExt.h"

@interface TestString : NSObject @end



@implementation TestString

-(void) test_string {
    assert_equal(@"a", [@" a " strip]);
    assert_equal(@"cba", [@"abc" reverse]);
    assert_equal(@"bc", [@"abc" slice:1 :2]);
    assert_equal(@"abcd", [@"abcff" gsub:@"ff" to:@"d"]);
    assert_equal(3, @"abc".length);
    assert_equal(true, [@"abc" include:@"a"]);
    assert_equal(@"aB", SWF(@"a%@", @"B"));
    assert_equal(@"aaaaa", [@"a" repeat:5]);
    assert_equal(3, [@"3" to_int]);
    assert_equal(3, @"3".to_int);
    assert_equal(3.14f, @"3.14".to_float);
    assert_equal(3.14f, @"3.14f".to_float);
    assert_equal(3.14, @"3.14".to_double);
    
    NSArray* expected = @[@"a", @"b", @"c"];
    assert_equal(expected, [@"a b c" split:@" "]);
}

@end