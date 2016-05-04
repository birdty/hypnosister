//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Tyler Bird on 2/17/16.
//  Copyright (c) 2016 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    self
    
    CGRect bounds = self.bounds;
    
    CGPoint center;
    
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 ) {
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    }
    
    path.lineWidth = 10;
    
    [[self circleColor] setStroke];
    
    [path stroke];
    
    UIImage * logoImage = [UIImage imageNamed:@"logo.png"];
    
    CGRect someRect;
    
    someRect.origin.x = self.bounds.origin.x + self.bounds.size.width / 2.0 - logoImage.size.width / 4.0;
    
    someRect.origin.y = self.bounds.origin.y + self.bounds.size.height / 2.0 - logoImage.size.height / 4.0;
    
    someRect.size.width = logoImage.size.width / 2.0;
    someRect.size.height = logoImage.size.height / 2.0;
    
    // install clipping path for color gradient
    // as a triangle around the image view just created.
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // save the graphics context.
    
    CGContextSaveGState(currentContext);
    
    CGFloat locations[3] = { 0.25, 0.77, 1.0 };
    CGFloat components[8] = { 1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0 };
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(
            colorspace,
            components,
            locations,
            2
    );
    
    CGPoint startPoint;
    startPoint.x = self.bounds.size.width / 2.0;
    startPoint.y = self.bounds.size.height / 2.0 - logoImage.size.height / 4.0;
    
    CGPoint endPoint;
    endPoint.x = self.bounds.size.width / 2.0;
    endPoint.y = self.bounds.size.height / 2.0 + logoImage.size.height / 4.0;
    
    UIBezierPath * clippingPath = [[UIBezierPath alloc] init];
    
    CGPoint topCenter;
    topCenter.x = self.bounds.size.width / 2.0;
    topCenter.y = self.bounds.size.height / 2.0 - (logoImage.size.height / 4.0);
    
    CGPoint bottomRight;
    bottomRight.x = self.bounds.size.width / 2.0 + (logoImage.size.width / 4.0);
    bottomRight.y = self.bounds.size.height / 2.0 + (logoImage.size.height / 4.0);
    
    CGPoint bottomLeft;
    bottomLeft.x = self.bounds.size.width / 2.0 - (logoImage.size.width / 4.0);
    bottomLeft.y = self.bounds.size.height / 2.0 + (logoImage.size.height / 4.0);
    
    [clippingPath moveToPoint:topCenter];
    [clippingPath addLineToPoint:bottomRight];
    [clippingPath addLineToPoint:bottomLeft];
    [clippingPath addLineToPoint:topCenter];

    // add clipping path to graphics context.
    
    [clippingPath addClip];
    
    // with clipping path draw gradient on current graphics context ( bitmap )
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    
    CGColorSpaceRelease(colorspace);
    
    CGContextRestoreGState(currentContext);
    
    
    CGContextSaveGState(currentContext);
    
    CGContextSetShadow(currentContext, CGSizeMake(4,7), 3);
    [logoImage drawInRect:someRect];

    
    CGContextRestoreGState(currentContext);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    float red = (arc4random() % 100)  / 100.0;
    float green = (arc4random() % 100)  / 100.0;
    float blue = (arc4random() % 100)  / 100.0;

    UIColor * randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.circleColor = randomColor;
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
