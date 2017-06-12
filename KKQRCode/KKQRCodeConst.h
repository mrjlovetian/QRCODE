//
//  KKQRCodeConst.h
//  Pods
//
//  Created by Mr on 2017/6/5.
//
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define KKQRCodeLog(...) NSLog(__VA_ARGS__)
#else
#define KKQRCodeLog(...)
#endif

#define KKQRCodeNotificationCenter [NSNotificationCenter defaultCenter]
#define KKQRCodeScreenWidth [UIScreen mainScreen].bounds.size.width
#define KKQRCodeScreenHeight [UIScreen mainScreen].bounds.size.height

/** 二维码冲击波动画时间 */
UIKIT_EXTERN CGFloat const KKQRCodeScanningLineAnimation;

/** 扫描得到的二维码信息 */
UIKIT_EXTERN NSString *const KKQRCodeInformationFromeScanning;

/** 从相册里得到的二维码信息 */
UIKIT_EXTERN NSString *const KKQRCodeInformationFromeAibum;

///公钥
UIKIT_EXTERN NSString *const KKRSA_Public_key;

///私钥
UIKIT_EXTERN NSString *const KKRSA_Privite_key;
