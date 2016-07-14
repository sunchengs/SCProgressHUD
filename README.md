# SCProgressHUD
轻量型ProgressHUD

##如何使用
使用起来很简单，基本上调用类方法就可以完成基本需求

1.加入头文件`#import "SCProgressHUD.h"`

2.调用
```
// 显示菊花
- (IBAction)showHUD:(id)sender {
    [SCProgressHUD showHUDAddedTo:self.view];
    [self performSelector:@selector(hidenHUD) withObject:nil afterDelay:2];
}

// 显示文字
- (IBAction)showMsg_inView:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" inView:self.view];
}

// 显示文字 + 消失后的回调
- (IBAction)showMsg_completed:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" completed:^{
        NSLog(@"completed");
    }];
}

// 显示文字 + 持久时间 + 消失后的回调
- (IBAction)showMsg_afterDelay_completed:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" afterDelay:2 completed:^{
        NSLog(@"completed");
    }];
}

// 显示文字 + 加载层 +持久时间 + 消失后的回调
- (IBAction)showMsg_inView_afterDelay_completed:(id)sender {
    [SCProgressHUD showMsg:@"SCProgressHUD" inView:self.view afterDelay:2 completed:^{
        NSLog(@"completed");
    }];
}

// 隐藏HUD
- (IBAction)hideHUDForView:(id)sender {
    [SCProgressHUD hideHUDForView:self.view];
}

- (void)hidenHUD
{
    [SCProgressHUD hideHUDForView:self.view];
}
```
