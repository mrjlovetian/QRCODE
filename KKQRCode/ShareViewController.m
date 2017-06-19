//
//  ShareViewController.m
//  YHJQRCode
//
//  Created by Mr on 2017/6/12.
//  Copyright © 2017年 余洪江. All rights reserved.
//

#import "ShareViewController.h"
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <Weibo/WeiboSDK.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)weixin:(id)sender {
    NSLog(@"微信");
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"share message";
    message.description = @"this message share detail, introduce share message content!";
    [message setThumbImage:[UIImage imageNamed:@"share_kber"]];
    message.mediaTagName = @"small media";
    
    ///分享图片
    WXImageObject *imageObject = [WXImageObject object];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"share_kber@3x" ofType:@"png"];
    imageObject.imageData = [NSData dataWithContentsOfFile:path];
    message.mediaObject = imageObject;
    
    ///分享网页
    WXWebpageObject *webObject = [WXWebpageObject object];
    webObject.webpageUrl = @"http://www.jianshu.com/p/1c1018580a58";
    message.mediaObject = webObject;
    
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = message;
    req.bText = NO;///分享文字YES
    req.scene = WXSceneSession;
    BOOL isShare = [WXApi sendReq:req];
    
    
    NSLog(@"风向结果%@", isShare?@"成功":@"失败");
}
- (IBAction)QQ:(id)sender {
    NSLog(@"qq");
    
    ///分享文字
    QQApiTextObject *textObj = [QQApiTextObject objectWithText:@"QQ分享，我是小江江"];
    
    ///分享图片
    QQApiImageObject *imageObj = [QQApiImageObject objectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share_kber@3x" ofType:@"png"]] previewImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share_kber@3x" ofType:@"png"]] title:@"这是张艳照" description:@"哈哈！骗你的"];
    
    ///网页分享
    QQApiWebImageObject *webObj = [QQApiWebImageObject objectWithPreviewImageURL:[NSURL URLWithString:@"http://www.baidu.com"] title:@"电影" description:@"好像打不开"];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imageObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    NSLog(@"-=-=-=-=-=%d", sent);
}
- (IBAction)weibo:(id)sender {
    NSLog(@"微博");
    ///文本消息
    WBMessageObject *messageObject = [WBMessageObject message];
    messageObject.text = @"微博发送消息";
    
    ///发送图片
    WBImageObject *imageObject = [WBImageObject object];
    imageObject.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share_kber@3x" ofType:@"png"]];
    
     messageObject.imageObject = imageObject;
    
    ///分享链接
    WBWebpageObject *webObject = [WBWebpageObject object];
    webObject.objectID = @"identifier1";
    webObject.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
    // 多媒体内容缩略图
    webObject.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share_kber@3x" ofType:@"png"]];
    webObject.webpageUrl = @"http://sina.cn?a=1";
    ///网页分享时必须添加标题内容
    webObject.title = @"微博分享";
    
    messageObject.mediaObject = webObject;
   
    
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:messageObject];
    [WeiboSDK sendRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
