//
//  NSDateExt.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSDateExt.h"

NSDate* DateTime(int year, int month, int day, int hour, int minute, int second) {
    return [NSDate year:year month:month day:day hour:hour minute:minute second:second];
}

NSDate* NSDateFromString(NSString* str) {
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:str];
}

@implementation NSDate (Ext)

#define UNIT_FLAGS_YMDHMS	(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
#define ONE_DAY_SECONDS     86400

+(NSDate*) year:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:UNIT_FLAGS_YMDHMS fromDate:(NSDate*)self];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    comps.hour = hour;
    comps.minute = minute;
    comps.second = second;
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

-(int) year {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return (int)comps.year;
}

-(int) month {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
    return (int)comps.month;
}

-(int) day {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
    return (int)comps.day;
}

-(int) hour {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    return (int)comps.hour;
}

-(int) minute {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self];
    return (int)comps.minute;
}

-(int) second {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self];
    return (int)comps.second;
}

-(int) weekday {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    return (int)comps.weekday;
}

-(NSDate*) tomorrow {
    return [self dateByAddingTimeInterval:ONE_DAY_SECONDS];
}

-(NSDate*) yesterday {
    return [self dateByAddingTimeInterval:-ONE_DAY_SECONDS];
}

@end



@implementation NSDate (CapitalizedExt)

-(NSString*) To_s {
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:self];
}

@end