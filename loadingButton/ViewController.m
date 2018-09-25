//
//  ViewController.m
//  loadingButton
//
//  Created by ios 4 on 9/24/18.
//  Copyright © 2018 ios 4. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LBVLoadingButtonView *circleView;
@property (weak, nonatomic) IBOutlet LBVLoadingButtonView *allInOneview;
@property (weak, nonatomic) IBOutlet LBVLoadingButtonView *uberLikeView;
@property (weak, nonatomic) IBOutlet LBVLoadingButtonView *fillingView;
@property (weak, nonatomic) IBOutlet LBVLoadingButtonView *indicatorViewLike;
@property (readonly,copy) NSTimer *tempTimer1;
@property (readonly,copy) NSTimer *tempTimer2;
@property (readonly,copy) NSTimer *tempTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.circleView addTarget:self action:@selector(animteView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.allInOneview addTarget:self action:@selector(animteView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.uberLikeView addTarget:self action:@selector(animteView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.fillingView addTarget:self action:@selector(animteView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.indicatorViewLike addTarget:self action:@selector(animteView:) forControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)animteView:(id)sender {
    LBVLoadingButtonView *button = sender;
    if(!button){
        return;
    }
    [button startLoading:button.setAnimationType];
    __block CGFloat percent = 0;
    switch (button.animationType) {
        case BACKGROUND_HIGHLIGHTER:{
            _tempTimer1 = nil;
            [_tempTimer1 invalidate];
            _tempTimer1 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
                percent += 10;
                [button fillTheButtonWith:percent];
                [button fillTheCircleStrokeLoadingWith:percent];
            }];
            break;
        }
        case CIRCLE_AND_TICK :{
            _tempTimer2 = nil;
            [_tempTimer2 invalidate];
            _tempTimer2 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
                percent += 10;
                [button fillTheButtonWith:percent];
                [button fillTheCircleStrokeLoadingWith:percent];
            }];
            break;
        }
        case ALL:
            {
                NSLog(@"");
                _tempTimer = nil;
                [_tempTimer invalidate];
            _tempTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
                percent += 10;
                [button fillTheButtonWith:percent];
                [button fillTheCircleStrokeLoadingWith:percent];
            }];
            break;
            }
        default:
            
            break;
    }
}


@end
