//
//  SAStepperControl.m
//  SAStepperControl
//
//  Created by Shams on 06/05/2014.
//  Copyright (c) 2014 SA. All rights reserved.
//

#import "SAStepperControl.h"

@interface SAStepperControl ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SAStepperControl


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self customInit];
    }
    return self;
}

- (void)customInit{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                           0,
                                                           30,
                                                           CGRectGetHeight(self.frame))];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = self.tintColor;
    self.label.adjustsFontSizeToFitWidth = YES;
    [self setDividerImage:[self imageFromView:self.label] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    [self addTarget:self action:@selector(actionValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)actionValueChanged:(id)sender{
    __weak typeof (self) weakSelf = self;
    if(self.actionBlock){
        self.actionBlock(weakSelf);
    }
}

- (UIImage *)dividerImageForLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState {
    if (fabs(self.value) < FLT_EPSILON ) {
        UIView *dividerContainer = [[UIView alloc] initWithFrame:CGRectMake(14,
                                                                   0,
                                                                   2,
                                                                   29)];
        
        dividerContainer.alpha = 0.5;
        dividerContainer.backgroundColor = self.tintColor;
        
        for (UIView *view in self.label.subviews) {
            [view removeFromSuperview];
            
        }
        
        self.label.text = nil;
        [self.label addSubview:dividerContainer];
        
        return [self imageFromView:self.label];
    }
    
    
    for (UIView *view in self.label.subviews) {
        [view removeFromSuperview];
        
    }
    
    self.label.text = [NSNumber numberWithDouble:self.value].stringValue;

    return [self imageFromView:self.label];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.label.textColor = self.tintColor;
    [self setDividerImage:[self imageFromView:self.label] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
}

- (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size,NO,[UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return viewImage;
}

@end
