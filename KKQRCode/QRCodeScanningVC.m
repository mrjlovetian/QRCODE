//
//  QRCodeScanningVC.m
//  KKQRCodeExample
//
//  Created by apple on 17/3/21.
//  Copyright © 2017年 JP_lee. All rights reserved.
//

#import "QRCodeScanningVC.h"
//#import "ScanSuccessJumpVC.h"
//#import "KKWebView.h"
#import "KKQRCodeConst.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeScanningVC ()

@end

@implementation QRCodeScanningVC

- (id)initRuleState:(AuthorizationStateBlock)authorizationHander
{
    self = [super init];
    if (self) {
        [self getRuleState:^(AuthorizationState state) {
            authorizationHander(state);
            if (AuthorizationStateAllowed == state) {
                // 注册观察者
                [KKQRCodeNotificationCenter addObserver:self selector:@selector(KKQRCodeInformationFromeAibum:) name:KKQRCodeInformationFromeAibum object:nil];
                [KKQRCodeNotificationCenter addObserver:self selector:@selector(KKQRCodeInformationFromeScanning:) name:KKQRCodeInformationFromeScanning object:nil];
            }else
            {
                NSLog(@"这是什么状态");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
            }
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)KKQRCodeInformationFromeAibum:(NSNotification *)noti {
//    NSString *string = noti.object;
    
    NSError *error = nil;
    if ([self.delegate respondsToSelector:@selector(QRCodeScanningVCResult:error:)]) {
        [self.delegate QRCodeScanningVCResult:noti.object error:error];
    }
    
    if (self.resultBlcok) {
        self.resultBlcok(noti.object, error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];

//    ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//    jumpVC.jump_URL = string;
//    [self.navigationController pushViewController:jumpVC animated:YES];
}

///扫码成功操作
- (void)KKQRCodeInformationFromeScanning:(NSNotification *)noti {
//    KKQRCodeLog(@"noti - - %@", noti);
//    NSString *string = noti.object;
    
    NSError *error = nil;
    if ([self.delegate respondsToSelector:@selector(QRCodeScanningVCResult:error:)]) {
        [self.delegate QRCodeScanningVCResult:noti.object error:error];
    }
    
    if (self.resultBlcok) {
        self.resultBlcok(noti.object, error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
//    if ([string hasPrefix:@"http"]) {
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_URL = string;
//        [self.navigationController pushViewController:jumpVC animated:YES];
//        
//    } else { // 扫描结果为条形码
//        
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_bar_code = string;
//        [self.navigationController pushViewController:jumpVC animated:YES];
//    }
}

- (void)getRuleState:(AuthorizationStateBlock)authorizationHander
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if (authorizationHander) {
                        authorizationHander(1);
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    KKQRCodeLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    KKQRCodeLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    if (authorizationHander) {
                        authorizationHander(2);
                    }
                    
                    // 用户第一次拒绝了访问相机权限
                    KKQRCodeLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            if (authorizationHander) {
                authorizationHander(1);
            }
//            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            if (authorizationHander) {
                NSLog(@"未获得权限");
                authorizationHander(2);
            }
            
//            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机 - KKQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
//            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            
//            [alertC addAction:alertA];
//            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
            if (authorizationHander) {
                authorizationHander(3);
            }
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)dealloc {
    KKQRCodeLog(@"QRCodeScanningVC - dealloc");
    [KKQRCodeNotificationCenter removeObserver:self];
}

@end
