#import <Foundation/Foundation.h>


#define EMPTY_STRING @""
#define SPACE @" "
#define LF @"\n"
#define TAB @"\t"
#define COMMA @","
#define COMMA_SPACE @", "

NSString* SWF(NSString* format, ...) ;
NSArray* _w(NSString* str) ;

@interface NSString (Ext)

-(NSString*) strip ;
-(NSArray*) split:(NSString*)sep ;
-(NSString*) reverse ;
-(NSString*) slice:(int)loc :(int)length_ ;
-(NSString*) slice:(int)loc backward:(int)backward ;
-(NSString*) gsub:(NSString*)str to:(NSString*)to ;
-(BOOL) include:(NSString*)str ;
-(NSString*) repeat:(int)times ;
-(int) to_int ;
-(float) to_float ;
-(double) to_double ;
-(NSString*) to_s ;

@end
