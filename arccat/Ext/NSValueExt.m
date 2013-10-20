//
//  NSValueExt.m
//  FindTheWords
//
//  Created by wookay on 13. 10. 6..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "NSValueExt.h"
#import "objc/runtime.h"

@implementation NSValue (Ext)

+(NSValue*) valueWithAny:(const void *)value objCType:(const char *)type {
	switch (*type) {
		case _C_CHR: // BOOL, char
			if (1 == (size_t)value) {
				return [NSNumber numberWithBool:TRUE];
			} else if (NULL == value) {
				return [NSNumber numberWithBool:FALSE];
			} else {
				return [NSNumber numberWithChar:*(char *)value];
			}
		case _C_UCHR: return [NSNumber numberWithUnsignedChar:*(unsigned char *)value];
		case _C_SHT: return [NSNumber numberWithShort:*(short *)value];
		case _C_USHT: return [NSNumber numberWithUnsignedShort:*(unsigned short *)value];
		case _C_INT:
			return [NSNumber numberWithInt:*(int *)value];
		case _C_UINT: return [NSNumber numberWithUnsignedInt:*(unsigned *)value];
		case _C_LNG: return [NSNumber numberWithLong:*(long *)value];
		case _C_ULNG: return [NSNumber numberWithUnsignedLong:*(unsigned long *)value];
		case _C_LNG_LNG: return [NSNumber numberWithLongLong:*(long long *)value];
		case _C_ULNG_LNG: return [NSNumber numberWithUnsignedLongLong:*(unsigned long long *)value];
		case _C_FLT:
			return [NSNumber numberWithFloat:*(float *)value];
		case _C_DBL:
            return [NSNumber numberWithDouble:*(double *)value];
		case _C_ID:
			if (nil == value) {
				return nil;
			} else {
                return [NSValue valueWithBytes:value objCType:type];;
			}
		case _C_PTR:
		case _C_STRUCT_B:
		case _C_ARY_B:
			if (NULL == value) {
				return nil;
			} else {
				return [NSValue valueWithBytes:value objCType:type];
			}
	}
	return [NSValue valueWithBytes:value objCType:type];
}

-(NSString*) valueDescription {
    if (!strcmp("@", [self objCType])) {
        if (nil == [self nonretainedObjectValue]) {
            return @"nil";
        } else {
            return [self nonretainedObjectValue];
        }
    } else {
        return [self description];
    }
}

@end