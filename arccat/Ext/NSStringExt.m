#import "NSStringExt.h"
#import "NSArrayExt.h"

NSString* SWF(NSString* format, ...) {
    va_list args;
    va_start(args, format);
    NSString* alloc_str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSString* ret = [NSString stringWithFormat:@"%@", alloc_str];
    //[alloc_str release];
    return ret;
}


NSArray* _w(NSString* str) {
    return [[str strip] componentsSeparatedByString:SPACE];
}



@implementation NSString (Ext)

-(NSString*) strip {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSArray*) split:(NSString*)sep {
    if ([EMPTY_STRING isEqualToString:self]) {
        return [NSArray array];
    }
    if ([EMPTY_STRING isEqualToString:sep]) {
        NSMutableArray* ary = [NSMutableArray array];
        for (int idx=0; idx<self.length; idx++) {
            NSRange range = NSMakeRange(idx, 1);
            NSString* ch = [self substringWithRange:range];
            [ary addObject:ch];
        }
        return ary;
    } else {
        return [self componentsSeparatedByString:sep];
    }
}

-(NSString*) reverse {
    return [[[self split:EMPTY_STRING] reverse] join:EMPTY_STRING];
}

-(NSString*) slice:(int)loc :(int)length_ {
    NSRange range;
    if (self.length > loc + length_) {
        range = NSMakeRange(loc, length_);
    } else {
        range = NSMakeRange(loc, self.length - loc);
    }
    return [self substringWithRange:range];
}

-(NSString*) slice:(int)loc backward:(int)backward {
    return [self slice:loc :self.length + backward + 1];
}

-(NSString*) gsub:(NSString*)str to:(NSString*)to {
    return [self stringByReplacingOccurrencesOfString:str withString:to];
}

-(BOOL) include:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    return NSNotFound != range.location;
}

-(NSString*) repeat:(int)times {
    NSMutableArray* ary = [NSMutableArray array];
    for (int idx = 0; idx < times; idx++) {
        [ary addObject:self];
    }
    return [ary componentsJoinedByString:EMPTY_STRING];
}

-(int) to_int {
    return [self intValue];
}

-(float) to_float {
    return [self floatValue];
}

-(double) to_double {
    return [self doubleValue];
}

-(NSString*) to_s {
    return self;
}

@end