//
//  SAStepperControl.h
//  SAStepperControl
//
//  Created by Shams on 06/05/2014.
//  Copyright (c) 2014 SA. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SAStepperControl;


typedef void (^SAStepperControlActionBlock)(SAStepperControl *control);

@interface SAStepperControl : UIStepper

@property (nonatomic,copy)SAStepperControlActionBlock actionBlock;

@end
