//
//  TimeChange.h
//  UnitTesting
//
//  Created by Edimax on 2015/8/20.
//  Copyright (c) 2015年 Winnie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeChange : NSObject


+ (NSString *)binaryTo64String:(NSString *)binary;
+ (NSString *)weekTimeTo64BitStringSrateDay:(int)startDay StartTime:(NSString *)startTime EndDay:(int)endDay EndTime:(NSString *)endTime;
- (NSString *)testExport;

@end
