//
//  IonIcons.m
//  ionicons-iOS is Copyright 2013 TapTemplate and released under the MIT license.
//  http://www.taptemplate.com
//  ==========================
//

#import "IonIcons.h"
#import "FontInspector.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@implementation IonIcons


//================================
// Font and Label Methods
//================================

NSString * const fontName = @"ionicons";

+ (UIFont*)fontWithSize:(CGFloat)size;
{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (!font) {
        // Note: we'll only come through here the first time [IonIcons fontWithSize:] is called.
        // The next time it's called, 'font' should be non-nil after the above initialization.
        [self registerIoniconsFont];
        font = [UIFont fontWithName:fontName size:size];
    }
    NSAssert(font, @"The ionicons font failed to load.");
    return font;
}

+ (void)registerIoniconsFont
{
    NSBundle *ioniconsBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self] pathForResource:@"ionicons" ofType:@"bundle"]];
    NSURL *url = [ioniconsBundle URLForResource:fontName withExtension:@"ttf"];
    NSData *fontData = [NSData dataWithContentsOfURL:url];
    if (fontData) {
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(font);
        CFRelease(provider);
    }
}

+ (UILabel*)labelWithIcon:(NSString*)icon_name
                     size:(CGFloat)size
                    color:(UIColor*)color
{
    UILabel *label = [[UILabel alloc] init];
    [IonIcons label:label setIcon:icon_name size:size color:color sizeToFit:YES];
    return label;
}

+ (void)label:(UILabel*)label
      setIcon:(NSString*)icon_name
         size:(CGFloat)size
        color:(UIColor*)color
    sizeToFit:(BOOL)shouldSizeToFit
{
    label.font = [IonIcons fontWithSize:size];
    
    [self checkGlyphsReferencedByString:icon_name existInFont:label.font];
    
    label.text = icon_name;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    if (shouldSizeToFit) {
        [label sizeToFit];
    }
    // NOTE: ionicons will be silent through VoiceOver, but the Label is still selectable through VoiceOver. This can cause a usability issue because a visually impaired user might navigate to the label but get no audible feedback that the navigation happened. So hide the label for VoiceOver by default - if your label should be descriptive, un-hide it explicitly after creating it, and then set its accessibiltyLabel.
    label.accessibilityElementsHidden = YES;
}

//================================
// Image Methods
//================================

+ (UIImage*)imageWithIcon:(NSString*)icon_name
                     size:(CGFloat)size
                    color:(UIColor*)color
{
    return [IonIcons imageWithIcon:icon_name
                         iconColor:color
                          iconSize:size
                         imageSize:CGSizeMake(size, size)];
}

+ (UIImage*)imageWithIcon:(NSString*)icon_name
                iconColor:(UIColor*)iconColor
                 iconSize:(CGFloat)iconSize
                imageSize:(CGSize)imageSize;
{
    UIFont *font = [IonIcons fontWithSize:iconSize];
    UIImage *image = nil;
    if (font) {
        
        [self checkGlyphsReferencedByString:icon_name existInFont:font];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6) {
            image = [self renderImageWithNSStringDrawingWithIconName:icon_name
                                                           iconColor:iconColor
                                                            iconSize:iconSize
                                                           imageSize:imageSize];
        } else {
#if DEBUG
            NSLog(@" [ IonIcons ] Using lower-res iOS 5-compatible image rendering.");
#endif
            image = [self renderImageWithCoreGraphicsWithIconName:icon_name
                                                        iconColor:iconColor
                                                         iconSize:iconSize
                                                        imageSize:imageSize];
        }
    }
    return image;
}

+ (BOOL)checkGlyphsReferencedByString:(NSString*)string existInFont:(UIFont*)font
{
    BOOL exists = [FontInspector doGlyphsReferencedInString:string existInFont:font];
    if (!exists) {
#if DEBUG
        NSLog(@"[ IonIcons.m ] WARNING: You attempted to use an icon_name '%@' does not exist in the font '%@'. Make sure that you are using the correct icon_name value from ionicons-codes.h",
              string, font.fontName);
#endif
    }
    return exists;
}

+ (UIImage*)renderImageWithNSStringDrawingWithIconName:(NSString*)icon_name iconColor:(UIColor*)iconColor iconSize:(CGFloat)iconSize imageSize:(CGSize)imageSize
{
    if (!iconColor) { iconColor = [self defaultColor]; }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    style.baseWritingDirection = NSWritingDirectionLeftToRight;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    NSAttributedString* attString = [[NSAttributedString alloc]
                                     initWithString:icon_name
                                     attributes:@{NSFontAttributeName: [IonIcons fontWithSize:iconSize],
                                                  NSForegroundColorAttributeName : iconColor,
                                                  NSParagraphStyleAttributeName : style}];
    // get the target bounding rect in order to center the icon within the UIImage:
    NSStringDrawingContext *ctx = [[NSStringDrawingContext alloc] init];
    CGRect boundingRect = [attString boundingRectWithSize:CGSizeMake(iconSize, iconSize) options:0 context:ctx];
    // draw the icon string into the image:
    [attString drawInRect:CGRectMake((imageSize.width/2.0f) - boundingRect.size.width/2.0f,
                                     (imageSize.height/2.0f) - boundingRect.size.height/2.0f,
                                     imageSize.width,
                                     imageSize.height)];
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (iconColor &&
        [iconImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
        iconImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return iconImage;
}

+ (UIImage*)renderImageWithCoreGraphicsWithIconName:(NSString*)icon_name iconColor:(UIColor*)iconColor iconSize:(CGFloat)iconSize imageSize:(CGSize)imageSize
{
    UILabel *iconLabel = [IonIcons labelWithIcon:icon_name size:iconSize color:iconColor];
    UIImage *iconImage = nil;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 1.0);
    {
        CGContextRef imageContext = UIGraphicsGetCurrentContext();
        if (imageContext != NULL) {
            UIGraphicsPushContext(imageContext);
            {
                CGContextTranslateCTM(imageContext,
                                      (imageSize.width/2.0f) - iconLabel.frame.size.width/2.0f,
                                      (imageSize.height/2.0f) - iconLabel.frame.size.height/2.0f);
                [[iconLabel layer] renderInContext: imageContext];
            }
            UIGraphicsPopContext();
        }
        iconImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return iconImage;
}

+ (UIColor*)defaultColor
{
    return [UIColor blackColor];
}

@end
