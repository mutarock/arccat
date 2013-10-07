//
//  UnitTest.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "Logger.h"
#import "objc/runtime.h"
#import "objc/message.h"
#import "NSValueExt.h"

@implementation UnitTest

+(void) run {
    [self setup];
    [self runAllTests];
    [self report];
}

+(void) setup {
    UnitTestManager.sharedInstance.test_started_at = [NSDate date];
    print_log_info(@"Started\n");
}

#define UNITTEST_TARGET_CLASS_FILTERING_SELECTOR @selector(hasPrefix:)
+(void) runAllTests {
    NSMutableArray* targetClasses = [NSMutableArray array];
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        Class classes[numClasses];
        (void) objc_getClassList (classes, numClasses);
        for (int idx = 0; idx < numClasses; idx++) {
            NSString* className = NSStringFromClass(classes[idx]);
            if (objc_msgSend(className, UNITTEST_TARGET_CLASS_FILTERING_SELECTOR, @"Test")) {
                [targetClasses addObject:className];
            }
        }
        //free(classes);
    }
    for (NSString* targetClassString in targetClasses) {
        Class targetClass = NSClassFromString(targetClassString);
        id target = [targetClass new];
        [self runTests:target];
    }
}

+(void) runTest:(id)target withName:(NSString*)name {
    UnitTestManager.sharedInstance.tests += 1;
    NSString* format = [NSString stringWithFormat:@"%%%ds        - %%s\n", FILENAME_PADDING-2];
    if (UnitTestManager.sharedInstance.dot_if_passed) {
    } else {
        NSString* className = [NSString stringWithFormat:@"%@", [target class]];
        print_log_info(format, [className UTF8String], [name UTF8String]);
    }
    SEL sel = NSSelectorFromString(name);
    objc_msgSend(target, sel);
}

+(void) runTests:(id)target {
    for (NSString* methodName in [self methodsForClass:[target class]]) {
        if ([methodName hasPrefix:@"test"]) {
            [self runTest:target withName:methodName];
        }
    }
}

+(NSArray*) methodsForClass:(Class)targetClass {
    NSMutableArray* ary = [NSMutableArray array];
    unsigned int count;
    Method *methods = class_copyMethodList((Class)targetClass, &count);
    for (unsigned int idx = 0; idx < count; ++idx) {
        Method method = methods[idx];
        SEL selector = method_getName(method);
        NSString *selectorName = NSStringFromSelector(selector);
        [ary addObject:selectorName];
    }
    return ary;
}

+(void) report {
    UnitTestManager.sharedInstance.elapsed = ABS([UnitTestManager.sharedInstance.test_started_at timeIntervalSinceNow]);
    print_log_info(@"\nFinished in %.3g seconds.\n", UnitTestManager.sharedInstance.elapsed);
    print_log_info(@"\n%d tests, %d assertions, %d failures, %d errors\n", UnitTestManager.sharedInstance.tests, UnitTestManager.sharedInstance.assertions, UnitTestManager.sharedInstance.failures, UnitTestManager.sharedInstance.errors);
}

+(BOOL) areEqual:(NSValue*)expected :(NSValue*)got {
    BOOL equals = false;
    if ([[expected nonretainedObjectValue] isKindOfClass:[NSArray class]]) {
        equals = [[expected nonretainedObjectValue] isEqualToArray:[got nonretainedObjectValue]];
    } else if ([[expected nonretainedObjectValue] isKindOfClass:[NSDictionary class]]) {
        equals = [[expected nonretainedObjectValue] isEqualToDictionary:[got nonretainedObjectValue]];
    } else if ([[expected nonretainedObjectValue] isKindOfClass:[NSString class]]) {
        equals = [[expected nonretainedObjectValue] isEqualToString:[got nonretainedObjectValue]];
    } else if ([[expected nonretainedObjectValue] isKindOfClass:[NSNumber class]]) {
        equals = [[expected nonretainedObjectValue] isEqualToNumber:[got nonretainedObjectValue]];
    } else if ([[expected nonretainedObjectValue] isKindOfClass:[NSDate class]]) {
        equals = [[expected nonretainedObjectValue] isEqualToDate:[got nonretainedObjectValue]];
    } else {
        equals = [expected isEqualToValue:got];
    }
    return equals;
}

+(void) assert:(NSValue*)got equals:(NSValue*)expected message:(NSString*)message inFile:(NSString*)file atLine:(int)line {
    UnitTestManager.sharedInstance.assertions += 1;
    BOOL equals = false;
    if (nil == expected && nil == got) {
        equals = true;
    } else {
        const char* expectedTypeCode = [expected objCType];
        const char* gotTypeCode = [got objCType];
        switch (expectedTypeCode[0]) {
            case _C_ID:
                equals = [self areEqual:expected :got];
                break;
            case _C_INT:
                if (_C_DBL == gotTypeCode[0] || _C_FLT == gotTypeCode[0]) {
                    equals = [(NSNumber*)expected isEqualToNumber:(NSNumber*)got];
                } else {
                    equals = [expected isEqualToValue:got];
                }
                break;
            case _C_FLT:
            case _C_DBL:
                if (_C_INT == gotTypeCode[0] || _C_FLT == gotTypeCode[0]) {
                    equals = [(NSNumber*)expected isEqualToNumber:(NSNumber*)got];
                } else {
                    equals = [expected isEqualToValue:got];
                }
                break;
            default:
                equals = [expected isEqualToValue:got];
                break;
        }
    }
    
    if (equals) {
        if (UnitTestManager.sharedInstance.dot_if_passed) {
            print_log_info(@".");
        } else {
            print_log_info(@"%@%d%@%@", file, line, @"passed: %@", [got valueDescription]);
        }
    } else {
        UnitTestManager.sharedInstance.failures += 1;
        printf("\n");
        
        NSString* expected_message;
        if (nil == message) {
            expected_message = [expected valueDescription];
        } else {
            expected_message = message;
        }
        print_log_info(@"%@ #%03d\nAssertion failed\nExpected: %@\nGot: %@\n", file, line, expected_message, [got valueDescription]);
    }
}

+(void) assert:(NSValue*)got equals:(NSValue*)expected inFile:(NSString*)file atLine:(int)line {
    return [self assert:got equals:expected message:nil inFile:file atLine:line];
}

@end




@implementation UnitTestManager
@synthesize dot_if_passed;
@synthesize test_started_at;
@synthesize elapsed;
@synthesize tests;
@synthesize assertions;
@synthesize failures;
@synthesize errors;

+ (UnitTestManager*) sharedInstance {
    static UnitTestManager* manager = nil;
    if (!manager) {
        manager = [UnitTestManager new];
    }
    return manager;
}

- (id) init {
    self = [super init];
    if (self) {
        dot_if_passed = true;
        test_started_at = nil;
        elapsed = 0;
        tests = 0;
        assertions = 0;
        failures = 0;
        errors = 0;
    }
    return self;
}

@end