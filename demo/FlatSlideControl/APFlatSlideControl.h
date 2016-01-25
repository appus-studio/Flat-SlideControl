//
//  APFlatSlideControl.h
//  AppusFlatSlideControl
//
//  Created by Alexey Kubas on 9/21/15.
//  Copyright (c) 2015 Appus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APFlatSlideControl;

IB_DESIGNABLE

@interface APFlatSlideControl : UIControl

@property(nonatomic,assign)NSUInteger leftValue;
@property(nonatomic,assign)NSUInteger rightValue;

@property(nonatomic,assign)IBInspectable NSUInteger thumbsCount; // min 2

@property(nonatomic,retain)IBInspectable UIColor *tintColor;
@property(nonatomic,retain)IBInspectable UIColor *groundColor;

@property(nonatomic,assign)IBInspectable CGFloat thumbRadius;

@property(nonatomic,assign)IBInspectable CGFloat lineWidth;


-(void)setLeftValue:(int)leftValue rightValue:(int)rightValue;


@end



