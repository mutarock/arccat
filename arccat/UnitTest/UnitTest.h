//
//  UnitTest.h
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __FILENAME__ (strrchr(__FILE__,'/')+1)
#define assert_equal(expected, got) \
do { \
    __typeof__(expected) __expected = (expected); \
    __typeof__(got) __got = (got); \
    NSValue* expected_encoded = [UnitTest valueWithBytes:&__expected objCType: @encode(__typeof__(expected))]; \
    NSValue* got_encoded = [UnitTest valueWithBytes:&__got objCType: @encode(__typeof__(got))]; \
    [UnitTest assert:got_encoded equals:expected_encoded inFile:[NSString stringWithUTF8String:__FILENAME__] atLine:__LINE__]; \
} while(0)


@interface UnitTestManager : NSObject {
    BOOL dot_if_passed;
    NSDate* test_started_at;
    NSTimeInterval elapsed;
    int tests;
    int assertions;
    int failures;
    int errors;
}
@property (nonatomic) BOOL dot_if_passed;
@property (nonatomic, retain) NSDate* test_started_at;
@property (nonatomic) NSTimeInterval elapsed;
@property (nonatomic) int tests;
@property (nonatomic) int assertions;
@property (nonatomic) int failures;
@property (nonatomic) int errors;
+ (UnitTestManager*) sharedInstance ;
@end



@interface UnitTest : NSObject

+(void) run ;
+(void) setup ;
+(void) report ;
+(void) runAllTests ;
+(void) runTests:(id)target ;
+(void) runTest:(id)target withName:(NSString*)name ;
+(void) assert:(NSValue*)got equals:(NSValue*)expected inFile:(NSString*)file atLine:(int)line ;
+(void) assert:(NSValue*)got equals:(NSValue*)expected message:(NSString*)message inFile:(NSString*)file atLine:(int)line ;
+(NSValue*) valueWithBytes:(const void *)value objCType:(const char *)type ;
+(NSString*) valueDescription:(NSValue*)value ;

@end