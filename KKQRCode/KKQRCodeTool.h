//
//  KKQRCodeTool.h
//  Pods
//
//  Created by Mr on 2017/6/5.
//
//

#import <UIKit/UIKit.h>

@interface KKQRCodeTool : NSObject
/** 生成一张普通的二维码 */
+ (UIImage *)KKgenerateWithDefaultQRCodeData:(NSDictionary *)dataDic imageViewWidth:(CGFloat)imageViewWidth;
/** 生成一张带有logo的二维码（logoScaleToSuperView：相对于父视图的缩放比取值范围0-1；0，不显示，1，代表与父视图大小相同） */
+ (UIImage *)KKgenerateWithLogoQRCodeData:(NSDictionary *)dataDic logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;
/** 生成一张彩色的二维码 */
+ (UIImage *)KKgenerateWithColorQRCodeData:(NSDictionary *)dataDic backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

+ (UIImage *)SG_generateWithColorQRCodeData:(NSString *)data backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

@end
