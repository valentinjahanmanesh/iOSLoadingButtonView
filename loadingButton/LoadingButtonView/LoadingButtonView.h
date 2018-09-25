//
//  LoadingButtonView.h
//  loadingButton
//
//  Created by ios 4 on 9/24/18.
//  Copyright © 2018 ios 4. All rights reserved.
//
@import UIKit;

typedef enum : NSUInteger {
    
    NONE = 0,
    TOP_LINE = 1,
    INDICATOR = 2,
    BACKGROUND_HIGHLIGHTER = 3,
    CIRCLE_AND_TICK = 4,
    ALL = 5
} LoadingType; 

IB_DESIGNABLE
@interface LoadingButtonView : UIButton

//these are used via interfacebuilder (you can set these in code too)
@property (assign) IBInspectable int setAnimationType;
@property (copy) IBInspectable UIColor *setLoadingColor;
@property (copy) IBInspectable UIColor *setFilledBackgroundColor;
@property (assign) IBInspectable BOOL *setIndicatorViewDarkStyle;
@property (assign) LoadingType animationType;
-(void) startLoading:(LoadingType) loadingType;
-(void) endAndDeleteLoading;
@end





