//
//  APFlatSlideControl.m
//  AppusFlatSlideControl
//
//  Created by Alexey Kubas on 9/21/15.
//  Copyright (c) 2015 Appus. All rights reserved.
//

#import "APFlatSlideControl.h"


@interface APFlatSlideControl()

@property (strong, nonatomic) CALayer *lineLayer;
@property (strong, nonatomic) NSMutableArray *markers;
@property (strong, nonatomic) NSMutableArray *intermediateMarkers;
@property (strong, nonatomic) CAShapeLayer *tappedMarker;
@property (assign, nonatomic) CGFloat tappedIndex;

@end

@implementation APFlatSlideControl{
    NSUInteger _leftValue;
    NSUInteger _rightValue;
    NSUInteger _thumbsCount;
    
    CGFloat _tempLeft;
    CGFloat _tempRight;
}

#pragma mark Drawing
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // ground thumbs
    [self drawGroundLine:context];
    // Ground lines
    [self drawGroundThumbs:context];
    // Intermediate markers
    [self addIntermediateMarkers];
    // Selected Markers
    [self createMarkers];
    // Selected Line
    [self drawSelectedLineAnimated:NO];
    // Postioning Intermediate markers
    [self updateIntermediateMarkersAnimated:NO];
    
}

#pragma mark - User Iteractions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * gesture = [touches anyObject];
    
    self.tappedIndex = [self pointToIndex:[gesture locationInView:self]];
    self.tappedMarker = [self findMarkerNearIndex:self.tappedIndex];
    
    if (self.tappedMarker){
        self.tappedMarker.frame = [self indexToRect:[self pointToIndex:[gesture locationInView:self]]];
        [self drawSelectedLineAnimated:YES];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * gesture = [touches anyObject];
    
    if (self.tappedMarker){
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        self.tappedMarker.frame = [self indexToRect:[self pointToIndex:[gesture locationInView:self]]];
        [self drawSelectedLineAnimated:NO];
        [CATransaction commit];
        
        [self updateValues];
        [self updateIntermediateMarkersAnimated:YES];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self stopMoving:[touches anyObject]];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self stopMoving:[touches anyObject]];
}

-(void)stopMoving:(UITouch*)touch{
    
    self.tappedMarker.frame = [self indexToRect:roundf([self pointToIndex:[touch locationInView:self]])];
    [self drawSelectedLineAnimated:YES];
    [self updateValues];
    [self updateIntermediateMarkersAnimated:YES];
    self.tappedMarker = nil;
    
}

#pragma mark - Corner Markers

-(void)createMarkers{
    self.markers = @[[self addPointToIndex:self.leftValue], [self addPointToIndex:self.rightValue]].mutableCopy;
}

-(CAShapeLayer*)addPointToIndex:(float)index{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointZero
                    radius:self.thumbRadius / 2.0
                startAngle:0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [path CGPath];
    layer.fillColor = self.tintColor.CGColor;
    
    layer.frame = [self indexToRect:index];
    [self.layer addSublayer:layer];
    
    return layer;
}

-(void)updateMarkers{
    
    CALayer *marker1 = self.markers[0];
    CALayer *marker2 = self.markers[1];
    
    marker1.frame = [self indexToRect:_leftValue];
    marker2.frame = [self indexToRect:_rightValue];
    
    if (marker1 && marker2){
        [self drawSelectedLineAnimated:YES];
        [self updateIntermediateMarkersAnimated:YES];
    }
    
}

-(CAShapeLayer*)findMarkerNearIndex:(float)index{
    
    for (CAShapeLayer *marker in self.markers){
        
        CGFloat markerIndex = [self pointToIndex:marker.frame.origin];
        
        if (roundf(index) == roundf(markerIndex)){
            return marker;
        }
    }
    
    return nil;
}

-(void)clearMarkers{
    
    for(CAShapeLayer *marker in self.markers){
        [marker removeFromSuperlayer];
    }
    [self.markers removeAllObjects];
    
    for(CAShapeLayer *marker in self.intermediateMarkers){
        [marker removeFromSuperlayer];
    }
    [self.intermediateMarkers removeAllObjects];
    
}


-(void)drawSelectedLineAnimated:(BOOL)animated{
    if (!self.lineLayer){
        self.lineLayer = [CALayer layer];
        [self.layer addSublayer:self.lineLayer];
        self.lineLayer.backgroundColor = self.tintColor.CGColor;
        [self.layer insertSublayer:self.lineLayer atIndex:0];
    }
    
    CALayer *marker1 = self.markers[0];
    CALayer *marker2 = self.markers[1];
    
    
    CGFloat leftOffset = MIN(marker1.frame.origin.x, marker2.frame.origin.x);
    CGFloat width = fabs(marker1.frame.origin.x - marker2.frame.origin.x);
    
    if (!animated){
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    }
    
    self.lineLayer.frame = CGRectMake(leftOffset,
                                      (self.bounds.size.height - self.lineWidth) / 2,
                                      width,
                                      self.lineWidth);
    
    
    
    if (!animated){
        [CATransaction commit];
    }
}

#pragma mark - Intermediate Markers

-(void)addIntermediateMarkers{
    
    self.intermediateMarkers = [NSMutableArray array];
    
    for (int i=0; i<self.thumbsCount; ++i) {
        CAShapeLayer *marker = [self addPointToIndex:i];
        [self.intermediateMarkers addObject:marker];
    }

}

-(void)updateIntermediateMarkersAnimated:(BOOL)animated{
    
    if (!animated){
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    }
    
    for (int i=0; i<self.thumbsCount; ++i) {
        CAShapeLayer *marker = self.intermediateMarkers[i];
        
        if ( i >= MIN(_tempLeft, _tempRight) && i <= MAX(_tempLeft, _tempRight)){
            marker.opacity = 1;
        }else{
            marker.opacity = 0;
        }
    }
    
    if (!animated){
        [CATransaction commit];
    }
}

-(void)updateValues{
    
    CALayer *marker1 = self.markers[0];
    CALayer *marker2 = self.markers[1];
    
    _tempLeft = MIN([self pointToIndex:marker1.frame.origin], [self pointToIndex:marker2.frame.origin]);
    _tempRight = MAX([self pointToIndex:marker1.frame.origin], [self pointToIndex:marker2.frame.origin]);

    if (round(_tempLeft) != _leftValue || round(_tempRight) != _rightValue){
        _leftValue = round(_tempLeft);
        _rightValue = round(_tempRight);
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];

    }
}

#pragma mark - Ground

-(void)drawGroundThumbs:(CGContextRef)context{
    //setup color for ground thumbs
    CGContextSetFillColorWithColor(context, self.groundColor.CGColor);
    // draw ground thumbs
    CGFloat thumbDiameter = self.thumbRadius * 0.9f;
    
    for (int i=0; i<self.thumbsCount; ++i) {
        CGRect thumbRect = CGRectMake((self.bounds.size.width - thumbDiameter) / (self.thumbsCount - 1) * i,
                                      (self.bounds.size.height - thumbDiameter) / 2,
                                      thumbDiameter,
                                      thumbDiameter);
        CGContextFillEllipseInRect(context, thumbRect);
    }
}
-(void)drawGroundLine:(CGContextRef)context{
    //setup color for ground line
    CGContextSetFillColorWithColor(context, self.groundColor.CGColor);
    // draw ground line
    CGRect thumbRect = CGRectMake(self.thumbRadius / 2,
                                  (self.bounds.size.height - self.lineWidth) / 2,
                                  self.bounds.size.width - self.thumbRadius,
                                  self.lineWidth);
    CGContextFillRect(context, thumbRect);
}

#pragma mark - Values set/get

-(void)setThumbsCount:(NSUInteger)thumbsCount{
    [self clearMarkers];
    _thumbsCount = MAX(2, thumbsCount);    
    _rightValue = 0;
    _leftValue = 0;
    _tempLeft = 0;
    _tempRight = 0;
    [self setNeedsDisplay];
}


-(void)setLeftValue:(int)leftValue rightValue:(int)rightValue{
    int newLeftValue = roundf(MAX(0, MIN(rightValue, leftValue)));
    int newRightValue = roundf(MIN(_thumbsCount - 1, MAX(leftValue, rightValue)));
    if (newLeftValue != _leftValue || newRightValue != _rightValue){
        _leftValue = newLeftValue;
        _rightValue = newRightValue;
        
        _tempLeft = leftValue;
        _tempRight = rightValue;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    [self updateMarkers];
}

-(NSUInteger)leftValue{
    return MAX(0, MIN(_rightValue, _leftValue));
}
-(NSUInteger)rightValue{
    return MIN(_thumbsCount, MAX(_leftValue, _rightValue));
}

-(void)setLeftValue:(NSUInteger)leftValue{
    _leftValue = leftValue;
    _tempLeft = leftValue;
}

-(void)setRightValue:(NSUInteger)rightValue{
    _rightValue = rightValue;
    _tempRight = rightValue;
}

#pragma mark - Converters


-(CGPoint)indexToPoint:(float)index{
    CGFloat stepWidth = (self.bounds.size.width - self.thumbRadius) / (self.thumbsCount - 1);
    return CGPointMake(self.thumbRadius/2.0 + index * stepWidth,
                       self.bounds.size.height / 2.0);
    
}

-(CGRect)indexToRect:(float)index{
    return (CGRect){[self indexToPoint:index], {self.thumbRadius, self.thumbRadius}};
}

-(CGFloat)pointToIndex:(CGPoint)point{
    CGFloat workingArea = self.frame.size.width - self.thumbRadius;
    CGFloat absoluteX = point.x - self.thumbRadius/2.0;
    return absoluteX / workingArea * (self.thumbsCount - 1) ;
}




@end
