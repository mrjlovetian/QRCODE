//
//  MainViewController.m
//  KKQRCode
//
//  Created by Mr on 2017/6/5.
//  Copyright © 2017年 余洪江. All rights reserved.
//

#import "MainViewController.h"
#import "QRCViewController.h"
#import "XIBViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
