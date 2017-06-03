//
//  FontInspector.m
//  Example-ionicons
//
//  Created by David Sweetman on 4/18/15.
//  Copyright (c) 2015 David Sweetman. All rights reserved.
//

#import "FontInspector.h"
#import <CoreText/CoreText.h>

@implementation FontInspector

+ (BOOL)doGlyphsReferencedInString:(NSString*)character existInFont:(UIFont*)font
{
    // safe for surrogate pairs http://www.objc.io/issue-9/unicode.html
    
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    
    NSUInteger length = [character lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
    
    UniChar characters[length];
    
    CGGlyph glyphs[length];
    
    [character getCharacters:characters range:NSMakeRange(0, length)];
    
    BOOL exists = CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, length);
    
    CFRelease(ctFont);
    
    return exists;
}

@end
