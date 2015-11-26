//
//  TimeChange.m
//  UnitTesting
//
//  Created by Edimax on 2015/8/20.
//  Copyright (c) 2015年 Winnie. All rights reserved.
//
//======================== Char To x64 Table ========================
//char,ascll,int	char,ascll,int      char,ascll,int      char,ascll,int
// 0,	48,	 0		 F,   70,	16		 V,	 86,	32		 k,	 107,   48
// 1,	49,	 1		 G,   71,	17		 W,	 87,	33		 l,	 108,   49
// 2,	50,	 2		 H,   72,	18		 X,	 88,	34		 m,	 109,   50
// 3,	51,	 3		 I,   73,	19		 Y,	 89,	35		 n,	 110,   51
// 4,	52,	 4		 J,   74,	20		 Z,	 90,	36		 o,	 111,   52
// 5,	53,	 5		 K,   75,	21		 `,	 96,	37		 p,	 112,   53
// 6,	54,	 6		 L,   76,	22		 a,	 97,	38		 q,	 113,   54
// 7,	55,	 7		 M,   77,	23		 b,	 98,	39		 r,	 114,   55
// 8,	56,	 8		 N,   78,	24		 c,	 99,	40		 s,	 115,   56
// 9,	57,	 9		 O,   79,	25		 d,	 100,	41		 t,	 116,   57
// @,	64,	10		 P,   80,	26		 e,	 101,	42		 u,	 117,   58
// A,	65,	11		 Q,   81,	27		 f,	 102,	43		 v,	 118,   59
// B,	66,	12		 R,   82,	28		 g,	 103,	44		 w,	 119,   60
// C,	67,	13		 S,   83,	29		 h,	 104,	45		 x,	 120,   61
// D,	68,	14		 T,   84,	30		 i,	 105,	46		 y,	 121,   62
// E,	69,	15		 U,   85,	31		 j,	 106,	47		 z,	 122,   63
//
//===================================================================
//
//一個bytes代表一個小時，每10分鐘一個單位(1代表關閉，0代表開啟)，共有64種組合。如上表
//
//範例：
//011110 = 30 = T (代表10分關閉，50分開啟)



#import "TimeChange.h"

#define bit64 @"0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZ`abcdefghijklmnopqrstuvwxyz"

@implementation TimeChange


+ (NSString *)binaryTo64String:(NSString *)binary
{
    NSString *string64 = @"";
    if (binary.length % 6 != 0) {
        for (int i = 0; i <binary.length % 6 ; i ++) {
            binary = [NSString stringWithFormat:@"%@0",binary];
        }
    }
    
    
    for (int i = 0; i <binary.length; i = i+6) {
        int loc = 0;
        NSString *binStr = [binary substringWithRange:NSMakeRange(i, 6)];
        
        loc = loc + 32 * [[binStr substringWithRange:NSMakeRange(0, 1)] intValue];
        loc = loc + 16 * [[binStr substringWithRange:NSMakeRange(1, 1)] intValue];
        loc = loc + 8 * [[binStr substringWithRange:NSMakeRange(2, 1)] intValue];
        loc = loc + 4 * [[binStr substringWithRange:NSMakeRange(3, 1)] intValue];
        loc = loc + 2 * [[binStr substringWithRange:NSMakeRange(4, 1)] intValue];
        loc = loc + 1 * [[binStr substringWithRange:NSMakeRange(5, 1)] intValue];
        
        string64 = [NSString stringWithFormat:@"%@%@",string64,[bit64 substringWithRange:NSMakeRange(loc, 1)]];
    }
    
    return string64;
}

+ (NSString *)weekTimeTo64BitStringSrateDay:(int)startDay StartTime:(NSString *)startTime EndDay:(int)endDay EndTime:(NSString *)endTime
{
    NSString *week10MinStr = @"";
    for (int i = 0; i < 144* ((startDay == 8 && endDay == 8 && ![startTime isEqualToString:endTime]) ? 1 : 7); i++) {
        week10MinStr = [NSString stringWithFormat:@"%@0",week10MinStr];
    }
    
    
    NSArray *startTimeAry = [startTime componentsSeparatedByString:@":"];
    NSArray *endIimeAry = [endTime componentsSeparatedByString:@":"];
    int startInt = 0;
    int endInt = 0;
    
    if (startDay == 8 && endDay == 8 && ![startTime isEqualToString:endTime]) {
        startInt = [[startTimeAry objectAtIndex:0] intValue]*6 + [[startTimeAry objectAtIndex:1] intValue]/10;
        endInt = [[endIimeAry objectAtIndex:0] intValue]*6 + [[endIimeAry objectAtIndex:1] intValue]/10;
        
        if (startInt < endInt) {
            for (int i = startInt; i < endInt; i ++) {
                week10MinStr = [week10MinStr stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"1"];
            }
        }else if (startInt > endInt){
            for (int i = startInt; i < (144*7 - startInt + endInt +1); i ++) {
                week10MinStr = [week10MinStr stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"1"];
                if (i == 144*7-1)
                    i = -1;
                
                if (i == endInt-1)
                    break;
                
            }
        }
        
        NSString *daySch = week10MinStr;
        week10MinStr = @"";
        for (int i = 0; i < 7; i ++) {
            week10MinStr = [NSString stringWithFormat:@"%@%@",week10MinStr,daySch];
        }
        
    }else if (endDay < 8 && startDay < 8){
        startInt = [[startTimeAry objectAtIndex:0] intValue]*6 + [[startTimeAry objectAtIndex:1] intValue]/10 + startDay*144;
        endInt = [[endIimeAry objectAtIndex:0] intValue]*6 + [[endIimeAry objectAtIndex:1] intValue]/10 + endDay*144;
        
        
        if (startInt < endInt) {
            for (int i = startInt; i < endInt; i ++) {
                week10MinStr = [week10MinStr stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"1"];
            }
        }else if (startInt > endInt){
            for (int i = startInt; i < (144*7 - startInt + endInt +1); i ++) {
                week10MinStr = [week10MinStr stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"1"];
                if (i == 144*7-1)
                    i = -1;
                
                if (i == endInt-1)
                    break;
                
            }
        }

    }
    
    return [TimeChange binaryTo64String:week10MinStr];
}

@end
