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
#import "FontInspector.h"
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
    UIFont *font = [IonIcons fontWithSize:10.0];
    
    for (NSString *iconName in iconNamesArray) {
        BOOL exists = [FontInspector doGlyphsReferencedInString:iconName existInFont:font];
        XCTAssertTrue(exists,
                      @"This iconName references a character that doesn't exist in this font: %@", iconName);
    }
}

- (BOOL)doesGlyph:(unichar)character existInFont:(CTFontRef)font
{
    UniChar characters[] = { character };
    CGGlyph glyphs[1] = { };
    
    BOOL ret = CTFontGetGlyphsForCharacters(font, characters, glyphs, 1);
    return ret;
}

@end
