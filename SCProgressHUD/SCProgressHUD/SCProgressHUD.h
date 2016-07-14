//
//  SCProgressHUD.h
//  SCProgressHUD
//
//  Created by 孙程 on 16/7/14.
//  Copyright © 2016年 Suncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowCompleted)(void);

@interface SCProgressHUD : UIView
{
    UIFont *msgFont;
}

@property (nonatomic, copy)   NSString                *msg;
@property (nonatomic, retain) UILabel                 *labelText;
@property (nonatomic, strong) UIActivityIndicatorView *HUDActivity;
//@property (nonatomic, strong) UIView                  *backgroundView;
@property (nonatomic, assign) float                    leftMargin;
@property (nonatomic, assign) float                    topMargin;
@property (nonatomic, assign) float                    animationLeftScale;
@property (nonatomic, assign) float                    animationTopScale;
@property (nonatomic, assign) float                    totalDuration;
@property (nonatomic, copy) ShowCompleted              completedBlock;

+ (void)showHUDAddedTo:(UIView *)view;
+ (BOOL)hideHUDForView:(UIView *)view;
+ (void)showMsg:(NSString *)msg inView:(UIView*)theView;
+ (void)showMsg:(NSString *)msg completed:(ShowCompleted)completedBlock;
+ (void)showMsg:(NSString *)msg afterDelay:(NSTimeInterval)delay completed:(ShowCompleted)completedBlock;
+ (void)showMsg:(NSString *)msg inView:(UIView*)theView afterDelay:(NSTimeInterval)delay completed:(ShowCompleted)completedBlock;



@end
