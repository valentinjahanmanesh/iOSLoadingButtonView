//
//  LoadingButtonView.m
//  loadingButton
//
//  Created by ios 4 on 9/24/18.
//  Copyright © 2018 ios 4. All rights reserved.
//

#import "LBVLoadingButtonView.h"

@interface LBVLoadingButtonView()
@property (assign,readonly) CGFloat percentFilled;
@property (assign,readonly) BOOL isloadingShowing;
@property (readonly) CAShapeLayer *filledLoadingLayer;
@property CAShapeLayer *circleStrokeLoadingLayer;

@property (readonly) UIButton *cacheButtonBeforeAnimation;
@end

@implementation LBVLoadingButtonView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animationType = NONE;
        _percentFilled = 0;
        if(self.setAnimationType!=0){
            self.animationType = self.setAnimationType;
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.setAnimationType!=0){
        self.animationType = self.setAnimationType;
    }
}

/**
 cache the button before any animation,we keep a reference to data so we can restore everything to the first place
 */
-(void) copyBeforeAnyChanges{
    _cacheButtonBeforeAnimation = [UIButton new];
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    _cacheButtonBeforeAnimation = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
}




-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        _percentFilled = 0;
        self.animationType = NONE;
        if (!self.setFilledBackgroundColor){
            self.setFilledBackgroundColor = [UIColor blackColor];
        }
        if (!self.setLoadingColor){
            self.setLoadingColor = [UIColor blackColor];
        }
        if(self.setAnimationType!=0){
            self.animationType = self.setAnimationType;
        }
       
    }
    return self;
}


/**
 start loading,this is our public api to start loading

 @param loadingType the loading style
 */
- (void)startLoading:(LoadingType)loadingType{
    if([self loadingIsShowing]){
        [self endAndDeleteLoading];
        return;
    }
    switch (loadingType) {
        case TOP_LINE:
            [self createTopLineLoading];
            break;
        case INDICATOR :
            [self createIndicatorLoading];
            break;
        case BACKGROUND_HIGHLIGHTER :
            [self createFillingLoading];
            break;
        case CIRCLE_AND_TICK :
            [self createCircleAndTick];
            break;
        case ALL:
            //top line animation
            [self createTopLineLoading];
            
            //indicator view animation
            [self createIndicatorLoading];
            
            //filling animation
            [self createFillingLoading];
            break;
        default:
            break;
    }
    
    //indicates that loading is showing
    _isloadingShowing = true;
}

/**
 move the text a little left and add the loading
 */
-(void) createIndicatorLoading{
    [UIView animateWithDuration:0.3 animations:^{
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [self layoutIfNeeded] ;
    }];
    
    //create the loading view
    [self createIndicatorView];
}

/**
 create indicator view
 */
-(void) createIndicatorView{
    UIActivityIndicatorView *indicator = [UIActivityIndicatorView new];
    indicator.activityIndicatorViewStyle = self.setIndicatorViewDarkStyle ? UIActivityIndicatorViewStyleGray:UIActivityIndicatorViewStyleWhite;
    indicator.frame = CGRectMake(0, 0, 30, 30);
    indicator.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + 15, self.bounds.size.height / 2);
    indicator.transform = CGAffineTransformMakeScale(0, 0);
    [indicator startAnimating];
    //i use some random id to find this view whenever needed
    indicator.tag = -11111111;
    indicator.userInteractionEnabled = NO;
    [self insertSubview:indicator atIndex:0];
    
    [UIView animateWithDuration:1 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveLinear animations:^{
        indicator.transform  = CGAffineTransformIdentity;
        [self layoutIfNeeded] ;
    } completion:nil];
}
-(void)removeIndicatorView{
    [[self viewWithTag: -11111111] removeFromSuperview];
}


///line loading
- (void) createTopLineLoading{
    //create our loading layer and line path
    CAShapeLayer *loadingLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    
    //height of the line
    CGFloat lineHeight = 2;
    
    //center the layer in our view and set the bounds
    loadingLayer.position = CGPointMake(self.frame.size.width / 2, -1);
    loadingLayer.bounds = CGRectMake(0, 0, self.frame.size.width, lineHeight);
    
    //draw our line
    [path moveToPoint:CGPointMake(0, -1)];
    [path addLineToPoint:CGPointMake(loadingLayer.bounds.size.width/2.4, -1)];
    
    //set the path layer, and costumizing it
    loadingLayer.path = path.CGPath;
    loadingLayer.strokeColor = [self.setLoadingColor CGColor];
    loadingLayer.strokeEnd = 1;
    loadingLayer.lineWidth = lineHeight;
    loadingLayer.lineCap = @"round";
    loadingLayer.contentsScale = UIScreen.mainScreen.scale;
    loadingLayer.accessibilityHint = @"button_topline_loading";
    //add the new layer
    [self.layer addSublayer:loadingLayer];
    
    //animated path
    UIBezierPath *animatedPath = [UIBezierPath new];
    [animatedPath moveToPoint:CGPointMake(loadingLayer.bounds.size.width / 1.2, -1)];
    [animatedPath addLineToPoint:CGPointMake(loadingLayer.bounds.size.width, -1)];
    
    //create our animation and add it to the layer
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath = @"path";
    animation.fromValue = (__bridge id)path.CGPath;
    animation.toValue = (__bridge id)animatedPath.CGPath;
    animation.duration = 1;
    animation.autoreverses = true;
    animation.repeatCount = 100;
    [loadingLayer addAnimation:animation forKey:nil];
}


-(void)removeTopLineLayer{
    //Reset button
    for (CALayer *layer in self.layer.sublayers ) {
        if ([layer.accessibilityHint  isEqual: @"button_topline_loading"] ){
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
    }
    
    //move the label view to center
    [UIView animateWithDuration:0.3 animations:^{
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self layoutIfNeeded] ;
    }];
}
/**
 check if loading is showing or there are some loading views left
 
 @return is loading showing?
 */
-(BOOL)loadingIsShowing{
    if([self viewWithTag: -11111111] ){
        return YES;
    }
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.accessibilityHint  isEqual: @"button_topline_loading"]){
            return YES;
        }
    }
    if (self.filledLoadingLayer || self.circleStrokeLoadingLayer){
        return YES;
    }
    return NO;
}


/**
 remove itemes that related to views
 */
- (void)endAndDeleteLoading{
    _isloadingShowing = false;
    _percentFilled = 0;
    
    //[self.tempTimer invalidate];
    
    [self removeIndicatorView];
    [self removeCircleLoadingLayer];
    [self removeFillingLayer];
    [self removeTopLineLayer];
    
}


/**
 create the filling layer
 
 @param percent of the completion something like 10,12,15...100
 */
-(void) fillTheButtonWith:(CGFloat)percent{
    _percentFilled = percent;
    if (percent >100){
        return;
    }
    if(!_isloadingShowing){
        return;
    }
    if (!self.filledLoadingLayer){
        return;
    }
    _percentFilled = 0;
    self.filledLoadingLayer.sublayers[0].bounds =  CGRectMake(0, (self.frame.size.height / 2), (self.frame.size.width * (percent  / 100)), self.frame.size.height);
    
}

/**
 create loading animation and layer
 */
-(void) createFillingLoading{
    _percentFilled = 0;
    //a shape for filling the button
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.backgroundColor = [self.setFilledBackgroundColor CGColor];
    layer.bounds = CGRectMake(0,0, 0, self.frame.size.height);
    layer.anchorPoint = CGPointMake(0,0.5);
    layer.position = CGPointMake(0, self.frame.size.height / 2);
    layer.accessibilityHint = @"button_filled_loading";
    layer.masksToBounds = YES;
    
    //create aniamtion
    _filledLoadingLayer = [CAShapeLayer new];
    self.filledLoadingLayer.bounds = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    self.filledLoadingLayer.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    self.filledLoadingLayer.accessibilityHint = @"button_filled_loading_parent";
    self.filledLoadingLayer.masksToBounds = YES;
    self.filledLoadingLayer.cornerRadius = self.layer.cornerRadius;
    [self.filledLoadingLayer insertSublayer:layer atIndex:0];
    [self.layer insertSublayer:self.filledLoadingLayer atIndex:0];
}
-(void) removeFillingLayer{
    [self.filledLoadingLayer removeFromSuperlayer];
    _filledLoadingLayer = nil;
}

-(void) createCircleAndTick{
    CGPoint center = self.center;
    [self copyBeforeAnyChanges];
    CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
    [self setTitle:@"" forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.center = center;
            self.bounds = CGRectMake(self.center.x, self.center.y, radius, radius);
            self.layer.cornerRadius = radius / 2;
            self.transform = CGAffineTransformMakeScale(-1,1);
            self.backgroundColor = self.setFilledBackgroundColor;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if(finished){
                [self createCircleLoadingLayer];
            }
        }];
    });
    
}

-(void) removeCircleLoadingLayer{
    if (!self.circleStrokeLoadingLayer){
        return;
    }
    [self.circleStrokeLoadingLayer removeAllAnimations];
    LBVLoadingButtonView __weak *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.bounds = CGRectMake(0, 0, weakSelf.cacheButtonBeforeAnimation.frame.size.width,weakSelf.cacheButtonBeforeAnimation.frame.size.height);
        weakSelf.layer.cornerRadius = weakSelf.cacheButtonBeforeAnimation.layer.cornerRadius;
        weakSelf.transform = CGAffineTransformIdentity;
        weakSelf.backgroundColor = weakSelf.cacheButtonBeforeAnimation.backgroundColor;

        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished){
            [weakSelf setTitle:weakSelf.cacheButtonBeforeAnimation.titleLabel.text forState:UIControlStateNormal];
            [weakSelf.circleStrokeLoadingLayer removeFromSuperlayer];
            weakSelf.circleStrokeLoadingLayer = nil;
        }
    }];
    return;
}

-(void) createCircleLoadingLayer{
    self.circleStrokeLoadingLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    self.circleStrokeLoadingLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame) + 5, CGRectGetHeight(self.frame) + 5);
    self.circleStrokeLoadingLayer.strokeColor = [self.setLoadingColor CGColor];
    self.circleStrokeLoadingLayer.lineWidth = 3;
    self.circleStrokeLoadingLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleStrokeLoadingLayer.lineCap = @"round";
    self.circleStrokeLoadingLayer.strokeStart = 0.0;
    self.circleStrokeLoadingLayer.strokeEnd = 0.0;
    CGPoint center = CGPointMake(CGRectGetMidX(self.circleStrokeLoadingLayer.bounds), CGRectGetMidY(self.circleStrokeLoadingLayer.bounds));
    self.circleStrokeLoadingLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) ;
    self.circleStrokeLoadingLayer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [path addArcWithCenter:center radius:(CGRectGetWidth(self.frame) / 2 + 4) startAngle:-M_PI/2 endAngle:-M_PI/2 + -2.0*M_PI clockwise:NO];
    self.circleStrokeLoadingLayer.path = path.CGPath;
    self.circleStrokeLoadingLayer.accessibilityHint = @"button_circle_loading_stroke_parent";
    [self.layer addSublayer:self.circleStrokeLoadingLayer];
    
}

/**
 fill the stroke
 
 @param percent of the completion something like 10,12,15...100
 */
-(void) fillTheCircleStrokeLoadingWith:(CGFloat)percent{
    
    if (percent >100){
        //[self.tempTimer invalidate];
        return;
    }
    if(!_isloadingShowing){
        return;
    }
    if (!self.circleStrokeLoadingLayer){
        return;
    }
    
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.fromValue =  [NSNumber numberWithFloat:self.percentFilled / 100];
    animation.toValue = [NSNumber numberWithFloat:percent / 100];
    animation.duration = 0.2;
    animation.keyPath = @"strokeEnd";
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.circleStrokeLoadingLayer addAnimation:animation forKey:nil];
    _percentFilled = percent;
}


/// convert degree to radian
///
/// - Parameter degree: degree
/// - Returns: calculated radian
- (float)degreeToRadian:(float_t)degree{
    return degree * M_PI / 180;
}
@end
