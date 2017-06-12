//
//  QRCViewController.m
//  KKQRCode
//
//  Created by Mr on 2017/6/5.
//  Copyright © 2017年 余洪江. All rights reserved.
//

#import "QRCViewController.h"
#import "KKQRCode.h"
#import "QRCodeScanningVC.h"

@interface QRCViewController ()<QRCodeScanningVCDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *codeView;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage2;

@property (nonatomic, strong)UIImageView *myView;

@end

@implementation QRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    [self.view addSubview:self.myView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)qrcode:(id)sender {
    QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] initRuleState:^(AuthorizationState state) {
        if (state == AuthorizationStateDenied) {
            NSLog(@"哦吼，获取相机的权限被拒绝了！！！");
        }
    }];
    vc.resultBlcok = ^(id result, NSError *err) {
        NSLog(@"-=-=-==%@-=-=-=-=%@", result, err);
    };
    
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)genderCode:(id)sender {
    NSDictionary *dic = @{@"name":@"mrjnumber", @"id":@"89701180595270098976", @"number":@"15757184409876sdfdhdbgd"};
//    self.codeView.image = [KKQRCodeTool KKgenerateWithDefaultQRCodeData:dic imageViewWidth:240.0];
//    self.codeView.image = [KKQRCodeTool KKgenerateWithLogoQRCodeData:dic logoImageName:@"share_kber" logoScaleToSuperView:0.1];
    

    
    // 2、将二维码显示在UIImageView上
    UIImage *image = [KKQRCodeTool KKgenerateWithColorQRCodeData:dic backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8] mainColor:[CIColor colorWithRed:0.3 green:0.2 blue:0.4]];
    UIImage *newimg = [image copy];
    
//    self.codeImage2.image = newimg;
    self.myView.image = image;
    self.codeView.image = image;
}

#pragma mark QRCodeScanningVCDelegate
- (void)QRCodeScanningVCResult:(id)result error:(NSError *)error
{
    NSLog(@"********%@************%@", result, error);
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
