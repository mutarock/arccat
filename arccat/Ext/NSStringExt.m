#import "NSStringExt.h"

@implementation NSString (Ext)

-(NSArray*) split:(NSString*)sep {
	return [self componentsSeparatedByString:sep];
}

@end
