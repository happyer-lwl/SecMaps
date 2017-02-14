//
//  PassWordInputViewController.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "PassWordInputViewController.h"
#import "InputPassWordView.h"
#import "SettingViewController.h"
#import "AppDelegate.h"

@interface PassWordInputViewController ()<UITextFieldDelegate>{
    
    NSString *_firstTimePassword;   // 第一次输入的密码
    
    BOOL _sectimeToInput;           // 是否第二次输入
}

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) InputPassWordView *inputView;
@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation PassWordInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"输入密码";
    
    if (_pwViewType == PWViewTypeFirstIn) {
        [self.view addSubview:self.tipLabel];
    }
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.passwordTF];
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 20.0f)];
        _tipLabel.font = [UIFont systemFontOfSize:18.0f];
        _tipLabel.textColor = MainTitleColor;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"请输入密码";
    }
    return _tipLabel;
}

- (InputPassWordView *)inputView{
    if (_inputView == nil) {
        CGFloat viewWidth = 130.0f;
        
        _inputView = [[InputPassWordView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - viewWidth) / 2, 200, viewWidth, viewWidth / 4.0f) passwordLength:4];
    }
    
    return _inputView;
}

- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 50)];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.hidden = NO;
        _passwordTF.delegate = self;
        _passwordTF.keyboardType = UIKeyboardTypeNumberPad;
        [_passwordTF addTarget:self action:@selector(passwordDidChanged:) forControlEvents:UIControlEventEditingChanged];
        [_passwordTF becomeFirstResponder];
    }
    return _passwordTF;
}

- (void)passwordDidChanged:(UITextField *)textField{
    
    [_inputView updateInputViewStatus:textField.text];
    
    if (_sectimeToInput) {
        
        if (textField.text.length == 4) {
            if ([_firstTimePassword isEqualToString:textField.text]) {
                
                // 保存至本地
                [[NSUserDefaults standardUserDefaults] setObject:_firstTimePassword forKey:@"PASSWORD"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                // 继续再次输入密码
                [self changeToSecondInput];
            }
        }
    }else{
        if (textField.text.length == 4) {
            
            if (_pwViewType == PWViewTypeCancel) {
                NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
                if ([textField.text isEqualToString:pw]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"PASSWORD"];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"TouchID"];
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isKindOfClass:[SettingViewController class]]) {
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                }
            }else if (_pwViewType == PWViewTypeNew) {
                
                // 再次输入密码
                [self changeToSecondInput];
            }else if (_pwViewType == PWViewTypeFirstIn) {
                
                NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
                if ([textField.text isEqualToString:pw]) {
                    
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [delegate goToMainVC];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
        }
    }
}

- (void)changeToSecondInput{
    
    _firstTimePassword = _passwordTF.text;
    _passwordTF.text = @"";
    [_inputView updateInputViewStatus:@""];
    
    _sectimeToInput = YES;
    
    self.title = @"请再次输入密码";
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
