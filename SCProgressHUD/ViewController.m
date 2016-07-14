//
//  ViewController.m
//  SCProgressHUD
//
//  Created by 孙程 on 16/7/14.
//  Copyright © 2016年 Suncheng. All rights reserved.
//

#import "ViewController.h"
#import "SCProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showHUD:(id)sender {
    [SCProgressHUD showHUDAddedTo:self.view];
    [self performSelector:@selector(hidenHUD) withObject:nil afterDelay:2];
}

- (IBAction)showMsg_inView:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" inView:self.view];
}

- (IBAction)showMsg_completed:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" completed:^{
        NSLog(@"completed");
    }];
}

- (IBAction)showMsg_afterDelay_completed:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" afterDelay:2 completed:^{
        NSLog(@"completed");
    }];
}

- (IBAction)showMsg_inView_afterDelay_completed:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" inView:self.view afterDelay:2 completed:^{
        NSLog(@"completed");
    }];
}

- (IBAction)hideHUDForView:(id)sender {
    [SCProgressHUD hideHUDForView:self.view];
}

- (void)hidenHUD
{
    [SCProgressHUD hideHUDForView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
