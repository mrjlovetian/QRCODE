//
//  QRCodeScanningVC.h
//  KKQRCodeExample
//
//  Created by apple on 17/3/21.
//  Copyright © 2017年 JP_lee. All rights reserved.
//

#import "KKQRCodeScanningVC.h"
#import "KKQRCode.h"

///获取相机的权限状态
typedef enum : NSUInteger {
    AuthorizationStateAllowed  =  1,
    AuthorizationStateDenied,
} AuthorizationState;

@protocol QRCodeScanningVCDelegate <NSObject>

- (void)QRCodeScanningVCResult:(id)result error:(NSError *)error;

@end

typedef void(^AuthorizationStateBlock)(AuthorizationState state);

typedef void(^QRCodeScanningVCBlock)(id result, NSError *err);

@interface QRCodeScanningVC : KKQRCodeScanningVC

- (id)initRuleState:(AuthorizationStateBlock)authorizationHander;

@property (nonatomic, copy)QRCodeScanningVCBlock resultBlcok;

@property (nonatomic, weak)id <QRCodeScanningVCDelegate> delegate;

@end
