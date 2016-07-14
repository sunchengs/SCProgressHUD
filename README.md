# SCProgressHUD
轻量型ProgressHUD

##如何使用
使用以来很简单，基本上调用类方法可以完成基本需求
、、、- (IBAction)showHUD:(id)sender {
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
}、、、
