//
//  UnitTestingTests.m
//  UnitTestingTests
//
//  Created by Edimax on 2015/8/20.
//  Copyright (c) 2015年 Winnie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "TimeChange.h"

@interface UnitTestingTests : XCTestCase

@end

@implementation UnitTestingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testBinaryTo64String
{
    NSString *day10MinSch = @"111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    NSString *string64 = [TimeChange binaryTo64String:day10MinSch];
    
    XCTAssert([string64 isEqualToString:@"zz0000000000000000000000"], @"Pass");
    
}

- (void)testWeekTimeTo64Bit
{
    
    NSString *string64 = [TimeChange weekTimeTo64BitStringSrateDay:0 StartTime:@"01:00" EndDay:1 EndTime:@"02:00"];
    NSLog(@"---%@---",string64);
    
    XCTAssert([string64 isEqualToString:@"0zzzzzzzzzzzzzzzzzzzzzzzzz0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"], @"Pass");

    NSString *string64EveryDay = [TimeChange weekTimeTo64BitStringSrateDay:8 StartTime:@"01:30" EndDay:8 EndTime:@"02:30"];

    XCTAssert([string64EveryDay isEqualToString:@"07s00000000000000000000007s00000000000000000000007s00000000000000000000007s00000000000000000000007s00000000000000000000007s00000000000000000000007s000000000000000000000"], @"Pass");

}

@end
