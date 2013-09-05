//
//  TestNumber.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"

@interface TestNumber : NSObject @end



@implementation TestNumber

-(void) test_number {
    assert_equal(3, 1+2);
    assert_equal(3.14, 3.14);
    assert_equal([NSNumber numberWithInt:5], @5);
    assert_equal(true, [@0 isKindOfClass:[NSNumber class]]);
    assert_equal((double)5, (int)5);
    assert_equal((int)5, (double)5);
    assert_equal([NSNumber numberWithDouble:5], @5);
}

@end



