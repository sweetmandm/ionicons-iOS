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
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testForValidFontName
{
    UIFont* fontName = [IonIcons fontWithSize:15.0];
    XCTAssertNotNil(fontName);
}

- (void)testIconNamesReturnGlyphs
{
    NSArray *iconNamesArray = allIconCodes();
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)[IonIcons fontWithSize:10].fontName, 10.0, NULL);
    
    for (NSString *iconName in iconNamesArray) {
        for (int i = 0; i < iconName.length; i++) {
            BOOL doesGlyphExist = [self doesGlyph:[iconName characterAtIndex:i] existInFont:font];
            XCTAssertNotEqual(doesGlyphExist, NO, @"Glyph doesn't exist");
        }
    }
    
    CFRelease(font);
}

- (BOOL)doesGlyph:(unichar)character existInFont:(CTFontRef)font
{
    UniChar characters[] = { character };
    CGGlyph glyphs[1] = { };
    
    BOOL ret = CTFontGetGlyphsForCharacters(font, characters, glyphs, 1);
    return ret;
}

@end
