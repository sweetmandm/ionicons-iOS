//
//  FontInspector.h
//  Example-ionicons
//
//  Created by David Sweetman on 4/18/15.
//  Copyright (c) 2015 TapTemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@class UIFont;
@interface FontInspector : NSObject

+ (BOOL)doGlyphsReferencedInString:(NSString*)character existInFont:(UIFont*)font;

@end
