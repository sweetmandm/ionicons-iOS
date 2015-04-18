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

@interface IonIcons()
+(UIColor*)defaultColor;
@end

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

// From http://stackoverflow.com/a/1262893/2588957
- (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)x andY:(int)y count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
    for (int i = 0 ; i < count ; ++i)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += bytesPerPixel;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }
    
    free(rawData);
    
    return result;
}

- (UIImage*)imageWithIconSizeTheSameAsImageSize:(CGFloat) size {
    return [IonIcons imageWithIcon:ion_alert size:size color:[UIColor whiteColor]];
}

- (UIImage*)imageWithIconSize:(CGFloat)iconSize imageSize:(CGSize)imageSize {
    return [IonIcons imageWithIcon:ion_alert iconColor:[UIColor whiteColor] iconSize:iconSize imageSize:imageSize];
}

- (UIImage*)imageWithIconSize:(CGFloat)iconSize imageSizeWithEqualHeightAndWidthLength:(CGFloat)imageSize {
    return [IonIcons imageWithIcon:ion_alert iconColor:[UIColor whiteColor] iconSize:iconSize imageSize:CGSizeMake(imageSize, imageSize)];
}

- (UIImage*)imageWithColor:(UIColor*)color {
    return [IonIcons imageWithIcon:ion_alert size:32.0 color:color];
}

- (UIImage*)imageWithColor:(UIColor*)color imageSize:(CGSize)imgSize {
    return [IonIcons imageWithIcon:ion_alert iconColor:color iconSize:32.0 imageSize:imgSize];
}

- (void)testImageForSize {
    
    CGFloat iconSize = 32.0;
    UIImage* img = [self imageWithIconSizeTheSameAsImageSize:iconSize];
    XCTAssertEqual(img.size.width, iconSize);
    XCTAssertEqual(img.size.height, iconSize);
    
    // using icon size with different image size
    CGFloat imageSize = 45.0;
    UIImage* imgWithImageSize = [self imageWithIconSize:iconSize imageSizeWithEqualHeightAndWidthLength:imageSize];
    XCTAssertEqual(imgWithImageSize.size.width, imageSize);
    XCTAssertEqual(imgWithImageSize.size.height, imageSize);
    XCTAssertNotEqual(imgWithImageSize.size.width, iconSize);
    XCTAssertNotEqual(imgWithImageSize.size.height, iconSize);
    
    // using icon size with different image size that has a different height and width
    CGFloat imageWidth = 44.0;
    CGFloat imageHeight = 54.0;
    UIImage* imgWithDifferentHeightAndWidth = [self imageWithIconSize:iconSize imageSize:CGSizeMake(imageWidth, imageHeight)];
    XCTAssertEqual(imgWithDifferentHeightAndWidth.size.width, imageWidth);
    XCTAssertEqual(imgWithDifferentHeightAndWidth.size.height, imageHeight);
    XCTAssertNotEqual(imgWithDifferentHeightAndWidth.size.width, iconSize);
    XCTAssertNotEqual(imgWithDifferentHeightAndWidth.size.height, iconSize);
    
}

- (void)testImageForNonNil {
    XCTAssertNotNil([self imageWithIconSizeTheSameAsImageSize:32.0]);
    XCTAssertNotNil([self imageWithIconSize:32.0 imageSizeWithEqualHeightAndWidthLength:45.0]);
    XCTAssertNotNil([self imageWithIconSize:32.0 imageSize:CGSizeMake(44.0, 54.0)]);
}

- (void)testImageColor {
    UIColor* testColor = [UIColor redColor];
    UIImage* imgOfSize = [self imageWithColor:testColor];
    [self validateThatIconColor:testColor isInImage:imgOfSize];
    
    UIImage* iconOfImgSize = [self imageWithColor:testColor imageSize:CGSizeMake(32.0, 43.0)];
    [self validateThatIconColor:testColor isInImage:iconOfImgSize];
    
    UIImage* iconWithNilColor = [self imageWithColor:nil imageSize:CGSizeMake(12.0, 12.0)];
    [self validateThatIconColor:[IonIcons defaultColor] isInImage:iconWithNilColor];
}

- (void)testInValidImageColor {
    UIColor* testColor = [UIColor redColor];
    UIImage* imgOfSize = [self imageWithColor:testColor];
    [self invalidateThatIconColor:[UIColor greenColor] isInImage:imgOfSize];
    
    UIImage* iconOfImgSize = [self imageWithColor:testColor imageSize:CGSizeMake(32.0, 43.0)];
    [self invalidateThatIconColor:[UIColor blueColor] isInImage:iconOfImgSize];
    
}

- (void)validateThatIconColor:(UIColor*)iconColor isInImage:(UIImage*)img {
    NSArray* colorArray = [self getRGBAsFromImage:img atX:0 andY:0 count:img.size.width*img.size.height];
    __block BOOL foundSameColorPixel = NO;
    [colorArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIColor class]]) {
            UIColor* currentPixelColor = (UIColor*)obj;
            NSLog(@"Color values: test %@ icon %@", iconColor, currentPixelColor);
            CGFloat r,g,b,a,ri,gi,bi,ai;
            [currentPixelColor getRed:&r green:&g blue:&b alpha:&a];
            [iconColor getRed:&ri green:&gi blue:&bi alpha:&ai];
            if ((a == ai) && (g == gi) && (b == bi) && (r == ri)) {
                foundSameColorPixel = YES;
                *stop = YES;
            }
        }
    }];
    
    XCTAssertTrue(foundSameColorPixel);
}

- (void)invalidateThatIconColor:(UIColor*)iconColor isInImage:(UIImage*)img {
    NSArray* colorArray = [self getRGBAsFromImage:img atX:0 andY:0 count:img.size.width*img.size.height];
    __block BOOL foundSameColorPixel = NO;
    [colorArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIColor class]]) {
            UIColor* currentPixelColor = (UIColor*)obj;
            NSLog(@"Color values: test %@ icon %@", iconColor, currentPixelColor);
            if (CGColorEqualToColor(iconColor.CGColor, currentPixelColor.CGColor)) {
                foundSameColorPixel = YES;
                *stop = YES;
            }
        }
    }];
    
    XCTAssertFalse(foundSameColorPixel);
}

@end
