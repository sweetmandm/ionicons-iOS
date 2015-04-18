//
//  FontInspector.m
//  Example-ionicons
//
//  Created by David Sweetman on 4/18/15.
//  Copyright (c) 2015 TapTemplate. All rights reserved.
//

#import "FontInspector.h"

@implementation FontInspector

+ (BOOL)doGlyphsReferencedInString:(NSString*)character existInFont:(UIFont*)font
{
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    
    BOOL exists = YES;
    for (int i = 0; i < character.length; i++) {
        UniChar characters[] = { [character characterAtIndex:i] };
        CGGlyph glyphs[1] = { };
        
        if (!CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, 1)) {
            exists = NO;
            break;
        }
    }
    
    CFRelease(ctFont);
    
    return exists;
}

@end
