//
//  NewsView.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 10/27/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "NewsView.h"

@implementation NewsView

@synthesize nArticleText;
@synthesize nArticleImage;



 - (id)init {
 self = [super init];
 if (self) {
     
 }
 return self;
 }
 

- (void)drawRect:(CGRect)rect {
    NSLog(@"HELLO WEEZY");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect aRect=[self bounds];
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor ].CGColor);
    //CGContextStrokeRect(context, aRect);
    

    /* Define some defaults */
    float padding = 10.0f;
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef) [UIFont systemFontOfSize:12].fontName, [UIFont systemFontOfSize:12].lineHeight, NULL);
    
    /* Get the graphics context for drawing */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /* Core Text Coordinate System is OSX style */
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    CGRect textRect = CGRectMake(padding, padding, self.frame.size.width - padding*2, self.frame.size.height - padding*2);
    
    /* Create a path to draw in and add our text path */
    CGMutablePathRef pathToRenderIn = CGPathCreateMutable();
    CGPathAddRect(pathToRenderIn, NULL, textRect);
    
    
    
    /* Add a image path to clip around */
    CGRect imgRect = CGRectMake(padding, 725, 200, 200);
    
    /* Create a path to draw in and add our text path */
    CGMutablePathRef pathToRenderImageIn = CGPathCreateMutable();
    CGPathAddRect(pathToRenderImageIn, NULL, imgRect);
    
    
    
    
    //CGPathAddRect(pathToRenderIn, NULL, imgRect);
    //CGContextStrokeRect(context, imgRect);
    
    //flip image
    UIImage* flippedImage = [UIImage imageWithCGImage:nArticleImage.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    [flippedImage drawInRect: imgRect];
    
    /* Build up an attributed string with the correct font */
    //NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"TEXT", @"")];
    NSString *formattedArticleText = [NSString stringWithFormat:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n%@",nArticleText];
    
    

    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: formattedArticleText];
    
    

    //NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: nArticleText];
    
    // NSLog(@"nArticleText == %@",nArticleText);
    NSLog(@"attrString == %@\n\n",attrString);
    //NSLog(@"nView.articleText == %@",nView.nArticleText); 

    
    CFAttributedStringSetAttribute((__bridge CFMutableAttributedStringRef) attrString, CFRangeMake(0, attrString.length), kCTFontAttributeName, font);
    
    
    
    
    
    
    
    /* Get a framesetter to draw the actual text */
    CTFramesetterRef fs = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    
   

    CTFrameRef frame = CTFramesetterCreateFrame(fs, CFRangeMake(0, attrString.length), pathToRenderIn, NULL);
    
    CFRange frameRange = CTFrameGetVisibleStringRange(frame);
    
    
    //NSLog(@"frame range ==> %ld  attrString Length ==>%ld",frameRange.length, attrString.length);
    
    CTFrameRef frame2 = CTFramesetterCreateFrame(fs, CFRangeMake(0, attrString.length), pathToRenderIn, NULL);
    
  //frame = CTFramesetterCreateFrame(fs2, CFRangeMake(frameRange.length, testString.length), pathToRenderIn, NULL);

    /* Draw the text */
    CTFrameDraw(frame, ctx);
    
    /* Draw the image */
    CGContextTranslateCTM(ctx, 0, 0);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CTFrameDraw(frame2, ctx);
    
    /* Release the stuff we used */
    CFRelease(frame);
    CFRelease(frame2);
    
    CFRelease(pathToRenderIn);
    
    CFRelease(pathToRenderImageIn);

    CFRelease(fs);
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    //[self.view addSubview:backgroundImage];
    
    [self addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]))];
    
    backgroundImage.alpha = .075;
    
}


@end
