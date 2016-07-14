//
//  SCProgressHUD.m
//  SCProgressHUD
//
//  Created by 孙程 on 16/7/14.
//  Copyright © 2016年 Suncheng. All rights reserved.
//

#import "SCProgressHUD.h"

static CGFloat const kWidth              = 200;
static CGFloat const kDefaultDuration    = 1.2;
static CGFloat const kAnimationTopScale  = 1.2;
static CGFloat const kAnimationLeftScale = 1.2;
static CGFloat const kTopMargin          = 10;
static CGFloat const kLeftMargin         = 10;

@implementation SCProgressHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)showMsg:(NSString *)msg inView:(UIView*)theView
{
    [SCProgressHUD showMsg:msg inView:theView afterDelay:kDefaultDuration completed:^{}];
}

+ (void)showMsg:(NSString *)msg completed:(ShowCompleted)completedBlock
{
    [SCProgressHUD showMsg:msg inView:nil afterDelay:kDefaultDuration completed:completedBlock];
}

+ (void)showMsg:(NSString *)msg afterDelay:(NSTimeInterval)delay completed:(ShowCompleted)completedBlock
{
    [SCProgressHUD showMsg:msg inView:nil afterDelay:delay completed:completedBlock];
}

+ (void)showMsg:(NSString *)msg inView:(UIView*)theView afterDelay:(NSTimeInterval)delay completed:(ShowCompleted)completedBlock
{
    SCProgressHUD *alert = [[SCProgressHUD alloc] initWithMsg:msg];
    if (!theView){
        [[self getUnhiddenFrontWindowOfApplication] addSubview:alert];
    }
    else{
        [[SCProgressHUD getWindow] addSubview:alert];
    }
    [alert showAlertWithMsg:delay];
    [alert completed:completedBlock];
}

- (void)completed:(ShowCompleted)completedBlock{
    self.completedBlock = completedBlock;
}

+ (void)showHUDAddedTo:(UIView *)view
{
    SCProgressHUD *alert = [[SCProgressHUD alloc] initHUD];
    UIView *backgroundView = [[UIView alloc] initWithFrame:view.bounds];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.tag = 100;
    UIWindow *window;
    if (!view){
       window = [self getUnhiddenFrontWindowOfApplication];
    }
    else{
        window = [SCProgressHUD getWindow];
    }
    [window addSubview:backgroundView];
    [window addSubview:alert];
    [alert show];
}

- (void)show
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    CGPoint center = [SCProgressHUD getWindow].center;
    self.center = center;
    
}

+ (BOOL)hideHUDForView:(UIView *)view
{
    SCProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        UIWindow *window;
        if (!view){
            window = [self getUnhiddenFrontWindowOfApplication];
        }
        else{
            window = [SCProgressHUD getWindow];
        }
        UIView *backgroundView = [window viewWithTag:100];
        if (backgroundView) {
            [backgroundView removeFromSuperview];
        }
        [hud hidenHUD];
        return YES;
    }
    return NO;
}

- (void)hidenHUD{
    [self.HUDActivity stopAnimating];
    [self removeFromSuperview];
}

+ (SCProgressHUD *)HUDForView:(UIView *)view {
    for (UIView *subview in [self getWindow].subviews) {
        if ([subview isKindOfClass:self]) {
            return (SCProgressHUD *)subview;
        }
    }
    return nil;
}



- (void)showAlertWithMsg:(float)duration
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    //    self.alpha = 0.0;
    
    CGPoint center = [SCProgressHUD getWindow].center;
    
    self.center = center;
    //    CAKeyframeAnimation* opacityAnimation= [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    //
    //    opacityAnimation.duration = kDefaultDuration;
    //    opacityAnimation.cumulative = YES;
    //    opacityAnimation.repeatCount = 1;
    //    opacityAnimation.removedOnCompletion = NO;
    //    opacityAnimation.fillMode = kCAFillModeBoth;
    //    opacityAnimation.values = [NSArray arrayWithObjects:
    //                               [NSNumber numberWithFloat:0.2],
    //                               [NSNumber numberWithFloat:0.92],
    //                               [NSNumber numberWithFloat:0.92],
    //                               [NSNumber numberWithFloat:0.1], nil];
    //
    //    opacityAnimation.keyTimes = [NSArray arrayWithObjects:
    //                                 [NSNumber numberWithFloat:0.0f],
    //                                 [NSNumber numberWithFloat:0.08f],
    //                                 [NSNumber numberWithFloat:0.92f],
    //                                 [NSNumber numberWithFloat:1.0f], nil];
    //
    //    opacityAnimation.timingFunctions = [NSArray arrayWithObjects:
    //                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
    //                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
    //                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];
    
    
    CAKeyframeAnimation* scaleAnimation =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = kDefaultDuration;
    scaleAnimation.cumulative = YES;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:self.animationTopScale],
                             [NSNumber numberWithFloat:1.0f],
                             [NSNumber numberWithFloat:1.0f],
                             [NSNumber numberWithFloat:1.0],
                             nil];
    
    scaleAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0f],
                               [NSNumber numberWithFloat:0.085f],
                               [NSNumber numberWithFloat:0.92f],
                               [NSNumber numberWithFloat:1.0f], nil];
    
    scaleAnimation.timingFunctions = [NSArray arrayWithObjects:
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.delegate = self;
    group.animations = [NSArray arrayWithObjects:scaleAnimation, nil];
    [self.layer addAnimation:group forKey:@"group"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        self.completedBlock();
        [self removeFromSuperview];
        
        /*
         // 消失动画
         if ([self.layer animationForKey:@"scale"] == anim)
         {
         self.completedBlock();
         [self removeFromSuperview];
         }
         else
         {
         CAKeyframeAnimation* scaleAnimation =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
         scaleAnimation.duration = 0.2;
         scaleAnimation.cumulative = YES;
         scaleAnimation.repeatCount = 1;
         scaleAnimation.removedOnCompletion = NO;
         scaleAnimation.fillMode = kCAFillModeForwards;
         scaleAnimation.values = [NSArray arrayWithObjects:
         [NSNumber numberWithFloat:0.8],
         [NSNumber numberWithFloat:0.8f],
         [NSNumber numberWithFloat:0.8f],
         [NSNumber numberWithFloat:0.8],
         nil];
         
         scaleAnimation.keyTimes = [NSArray arrayWithObjects:
         [NSNumber numberWithFloat:0.0f],
         [NSNumber numberWithFloat:0.05f],
         [NSNumber numberWithFloat:0.15f],
         [NSNumber numberWithFloat:1.0f], nil];
         
         scaleAnimation.timingFunctions = [NSArray arrayWithObjects:
         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];
         scaleAnimation.delegate = self;
         [self.layer addAnimation:scaleAnimation forKey:@"scale"];
         
         }
         */
    }
}

- (id)initHUD
{
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, 77,77);
        self.HUDActivity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.HUDActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.HUDActivity.hidesWhenStopped = YES;
        [self.HUDActivity startAnimating];
        [self  addSubview:self.HUDActivity];
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (id)initWithMsg:(NSString *)message
{
    if (self = [super init]) {
        
        self.msg = message;
        self.leftMargin         = kLeftMargin;
        self.topMargin          = kTopMargin;
        self.totalDuration      = kDefaultDuration;
        self.animationTopScale  = kAnimationTopScale;
        self.animationLeftScale = kAnimationLeftScale;
        
        msgFont = [UIFont systemFontOfSize:14.0f];
        CGSize textSize = [self getSizeFromString:self.msg];
        
        self.bounds = CGRectMake(0, 0, kWidth, textSize.height>32?(textSize.height + self.topMargin * 2):50);
        
        self.labelText = [[UILabel alloc] init];
        self.labelText.text = _msg;
        self.labelText.numberOfLines = 0;
        self.labelText.font = msgFont;
        self.labelText.backgroundColor = [UIColor clearColor];
        self.labelText.textColor = [UIColor whiteColor];
        self.labelText.textAlignment = NSTextAlignmentCenter;
        [self.labelText setFrame:CGRectMake(self.leftMargin, (self.bounds.size.height - textSize.height) / 2.0,kWidth - self.leftMargin * 2, textSize.height)];
        [self  addSubview:self.labelText];
        
        self.layer.cornerRadius = 10;
        
    }
    return self;
}

+ (UIWindow *) getUnhiddenFrontWindowOfApplication{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    NSInteger windowCnt = [windows count];
    for (NSInteger i = windowCnt - 1; i >= 0; i--) {
        UIWindow* window = [windows objectAtIndex:i];
        if (FALSE == window.hidden) {
            if (window.frame.size.height > 50.0f) {
                return window;
            }
        }
    }
    return NULL;
}

+ (UIWindow *)getWindow
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}

- (CGSize)getSizeFromString:(NSString *)_theString
{
    UIFont *theFont = msgFont;
    CGSize size = CGSizeMake(kWidth - self.leftMargin * 2, CGFLOAT_MAX);
    CGRect tempSize = [_theString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:theFont} context:nil];
    return tempSize.size;
}


@end
