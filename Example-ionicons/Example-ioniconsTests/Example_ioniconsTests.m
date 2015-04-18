//
//  Example_ioniconsTests.m
//  Example-ioniconsTests
//
//  Created by ds on 10/30/13.
//  Copyright (c) 2013 TapTemplate. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "allIconCodes.h"
#import "IonIcons.h"
@import CoreText;

@interface Example_ioniconsTests : XCTestCase

@end

@implementation Example_ioniconsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"%@", allIconCodes());
    XCTAssertNil(nil);
}

- (void)testForValidFontName
{
    UIFont* fontName = [IonIcons fontWithSize:15.0];
    XCTAssertNotNil(fontName);
}

- (void)testIconNamesReturnGlyphs
{
    NSArray *iconNamesArray = [self iconNamesArray];
    UIFont *font = [IonIcons fontWithSize:10];
    
    for (NSString *iconName in iconNamesArray) {
        for (int i = 0; i < iconName.length; i++) {
            BOOL doesGlyphExist = [self doesGlyph:[iconName characterAtIndex:i] existInFont:font];
            XCTAssertNotEqual(doesGlyphExist, NO, @"Glyph doesn't exist");
        }
    }
}

- (BOOL)doesGlyph:(unichar)character existInFont:(UIFont *)font
{
    UniChar characters[] = { character };
    CGGlyph glyphs[1] = { };
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
    
    BOOL ret = CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, 1);
    
//    CFRelease(ctFont);
    
    return ret;
}

- (NSArray *)iconNamesArray
{
    return @[ion_android_cart, ion_android_add_circle];
}

@end
