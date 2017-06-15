//
//  MainViewController.m
//  YHJQRCode
//
//  Created by Mr on 2017/6/5.
//  Copyright © 2017年 余洪江. All rights reserved.
//

#import "MainViewController.h"
#import "QRCViewController.h"
#import "XIBViewController.h"
#import "ShareViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)qrcode:(id)sender {
    QRCViewController *vc = [[QRCViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)xib:(id)sender {
    XIBViewController *vc = [[XIBViewController alloc] initWithNibName:@"XIBViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)share:(id)sender {
    ShareViewController *shareVC = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:shareVC animated:YES];
}

- (IBAction)date:(id)sender {
//    NSDate *nowDate = [NSDate date];
//    
//    NSString *serverTime = @"2017-06-14 10:20:20";
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSTimeZone *serverTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];///获取服务端时区
//    
//    [dateFormat setTimeZone:serverTimeZone];
//    
//    NSDate *serverDate = [dateFormat dateFromString:serverTime];///获得服务短时间
//    
//    NSTimeInterval serverTimeInterVal = [serverTimeZone secondsFromGMTForDate:nowDate];///服务端和标准时间的差值
//    
//    NSTimeZone *sysTimeZone = [NSTimeZone systemTimeZone];///获得系统时区
//    
//    NSTimeInterval sysTimeInterval = [sysTimeZone secondsFromGMTForDate:nowDate];///本机时间和标准时间差值
//    
//    NSDate *sysDate = [nowDate dateByAddingTimeInterval:sysTimeInterval];///获得本机时间
//    
//    NSTimeInterval finalTimeInval = sysTimeInterval - serverTimeInterVal;
//    
//    NSDate *finalServerDate = [sysDate dateByAddingTimeInterval:finalTimeInval];///服务端相对本机时间
//    
//    NSDate *serverShowDate = [serverDate dateByAddingTimeInterval:-finalTimeInval];
//    
//    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
//    
//    newFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    [newFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    
//    NSLog(@"服务端时间%@\n手机现在使用的时间%@\n服务端相对手机时间%@\n服务端显示在手机短时间%@", [dateFormat stringFromDate:serverDate], [newFormatter stringFromDate:sysDate], [newFormatter stringFromDate:finalServerDate], [dateFormat stringFromDate:serverShowDate]);
    
    [self handleServerTime:@"2017-06-14 10:20:20"];
}

///服务端时间转成本地时间，时区发生改变
- (NSString *)handleServerTime:(NSString *)serverTime
{
    if (serverTime.length > 19) {
        serverTime = [serverTime substringToIndex:19];
    }
    
    ///系统时间
    NSDate *date = [NSDate date];
    
    ///标准时区
    NSTimeZone *standardTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    ///手机系统时区
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    ///服务端时区, 默认是东八区
    NSTimeZone *serverTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    
    ///系统时区和标准时间的差值
    NSTimeInterval sysInter = [systemTimeZone secondsFromGMTForDate:date];
    
    ///服务端和标准时间的差值
    NSTimeInterval serInter = [serverTimeZone secondsFromGMTForDate:date];
    
    ///服务端和手机的差值
    NSTimeInterval counInter = sysInter - serInter;
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [formate setTimeZone:standardTimeZone];
    NSDate *serDate = [formate dateFromString:serverTime];
    NSDate *newServerDate = [serDate dateByAddingTimeInterval:counInter];
    NSString *phoneTime = [formate stringFromDate:newServerDate];
    
    NSLog(@"手机显示时间是%@", phoneTime);
    return phoneTime;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
