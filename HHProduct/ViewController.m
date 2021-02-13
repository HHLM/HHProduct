////
////  ViewController.m
////  HHProduct
////
////  Created by AYS on 2020/8/7.
////  Copyright © 2020 024084. All rights reserved.
////
//
//#import "ViewController.h"
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    NSLog(@"%d",[self ToHex:@"F3"]);
//    NSLog(@"%d",[self ToHex:@"9A"]);
//    NSLog(@"%012lld",strtoll(@"9AF3FFFFFFF".UTF8String, 0, 16));
//
//    ;
//}
//
//- (int)ToHex:(NSString *)tmpid
//{
//    int int_ch;
//
//    unichar hex_char1 = [tmpid
//                         characterAtIndex:0];
//////两位16进制数中的第一位(高位*16)
//
//    int int_ch1;
//
//    if (hex_char1 >= '0' && hex_char1 <= '9') int_ch1 = (hex_char1 - 48) * 16;
////// 0 的Ascll - 48
//
//    else if (hex_char1 >=
//             'A' && hex_char1 <= 'F') int_ch1 = (hex_char1 - 55) * 16;
////// A 的Ascll - 65
//
//    else int_ch1 = (hex_char1 - 87) * 16;
////// a 的Ascll - 97
//
//    unichar hex_char2 = [tmpid
//                         characterAtIndex:1];
/////两位16进制数中的第二位(低位)
//
//    int int_ch2;
//
//    if (hex_char2 >= '0' && hex_char2 <= '9') int_ch2 = (hex_char2 - 48);
////// 0 的Ascll - 48
//
//    else if (hex_char1 >=
//             'A' && hex_char1 <= 'F') int_ch2 = hex_char2 - 55;
////// A 的Ascll - 65
//
//    else int_ch2 = hex_char2 - 87;
////// a 的Ascll - 97
//
//    int_ch = int_ch1 + int_ch2;
//
//    NSLog(@"int_ch=%d", int_ch);
//
//    return int_ch;
//}
//
//@end

//
//  ViewController.m
//  XTPopView
//
//  Created by zjwang on 16/5/23.
//  Copyright © 2016年 夏天. All rights reserved.
//

#import "ViewController.h"
#import "XTPopView.h"

#import <UdeskMChatSDK/UdeskMChatSDK.h>
#import "UdeskMChatUIKit.h"
#import <CommonCrypto/CommonDigest.h>
//#import "UMCHTTPManager.h"
#import "UMCSDKManager.h"
#import "UMCHelper.h"
#import "HHLoadHUD.h"
#import "HHQDViewController.h"
#import "HHSnowViewController.h"

#define Udesk_WebIM_Key            @"9e4510dc4c67ead3c366a35b138cdf2d"
#define udesk_domian               @"aiyingshiaiyingshi.udesk.cn"
#define udesk_appid                @"50207b54e9759654"
#define udesk_appkey               @"8c639802e21b1e9fac52d6c05591830e"
#define udesk_tenantid             @"1e4bdeab-6317-4640-93ea-c7f2591d1bd4"

@interface ViewController ()<SelectIndexPathDelegate,UITextFieldDelegate>
@property(strong,readwrite,nonatomic)UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *cardTF;
@property (nonatomic, strong) NSMutableArray *customButtons;
@end

@implementation ViewController
- (IBAction)showHUD:(id)sender {
    [HHLoadHUD ays_showHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HHLoadHUD ays_hiddenHUD];
    });
}
- (IBAction)hh_qiandao:(id)sender {
    HHQDViewController *vc = [[HHQDViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    // Do any additional setup after loading the view, typically from a nib.
    self.cardTF.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 40, 40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"➕" forState:UIControlStateNormal];
    btn.backgroundColor =[UIColor redColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 100, 50);
    _button.center = self.view.center;
    [self.view addSubview:_button];
    _button.backgroundColor = [UIColor colorWithRed:0.3434 green:0.7864 blue:1.0 alpha:1.0];
    [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (NSMutableArray *)customButtons {
    if (!_customButtons) {
        _customButtons = [NSMutableArray array];
    }return _customButtons;
}
- (void)config {
//    [UMCLanguage sharedInstance].language = @"汉语";
    
    NSString *bundlePath = [[NSBundle bundleForClass:[ViewController class]] pathForResource:@"udCustomBundle" ofType:@"bundle"];
//    [UMCLanguage sharedInstance].customBundle = [NSBundle bundleWithPath:bundlePath];
    [UMCManager setIsDeveloper:NO];
    
    NSTimeInterval s = [[NSDate date] timeIntervalSince1970];
    NSString *sha1 = [NSString stringWithFormat:@"%@%@%.f",udesk_tenantid,udesk_appkey,s];
    
    
    NSString *sign = [self sha1:sha1];
    NSString *timestamp = [NSString stringWithFormat:@"%.f",s];
    UMCSystem *system = [UMCSystem new];
    
    system.UUID = @"1e4bdeab-6317-4640-93ea-c7f2591d1bd4";
    system.timestamp = timestamp;
    system.sign = sign;
    
    UMCCustomer *customer = [UMCCustomer new];
    customer.euid = @"aiyingshi";
    //customer.euid = @"27";
    customer.name = @"爱婴室";
    
    [UMCManager initWithSystem:system customer:customer completion:^(NSError *error) {
        
        [UMCManager merchantsUnreadCountWithEuid:nil completion:^(NSInteger unreadCount) {
            //未读消息角标个数
        }];
    }];
}

- (IBAction)hh_chatList:(id)sender {
    //聊天
    UMCSDKManager *sdkManager = [[UMCSDKManager alloc] initWithMerchantEuid:@"aiyingshi"];
    sdkManager.sdkConfig = [UMCSDKConfig sharedConfig];;
    [sdkManager pushUdeskInViewController:self completion:nil];
}

//咨询的对象
- (UMCSDKConfig *)getConfig {

    UMCSDKConfig *config = [UMCSDKConfig sharedConfig];

    //按钮位于输入框上方
    UMCCustomButtonConfig *buttonConfig1 = [[UMCCustomButtonConfig alloc] initWithTitle:@"自定义按钮1" clickBlock:^(UMCCustomButtonConfig *customButton, UMCIMViewController *viewController) {
            //do something
          //UdeskChatViewController 有可以发送消息的方法。
    }];
    buttonConfig1.type = UMCCustomButtonTypeInInputTop;

    //按钮位于更多
    UMCCustomButtonConfig *buttonConfig2 = [[UMCCustomButtonConfig alloc] initWithTitle:@"自定义按钮2" clickBlock:^(UMCCustomButtonConfig *customButton, UMCIMViewController *viewController) {
            //do something
          //UdeskChatViewController 有可以发送消息的方法。
    }];
    buttonConfig2.type = UMCCustomButtonTypeInMoreView;

    config.showCustomButtons = YES;
    config.customButtons = @[buttonConfig1,buttonConfig2];
    
    UMCProduct *product = [[UMCProduct alloc] init];
    product.title = @"iPhone X";
    product.image = @"https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/1917047079/TB1IfFybl_85uJjSZPfXXcp0FXa_!!0-item_pic.jpg_460x460Q90.jpg";
    product.url = @"http://www.apple.com/cn";

    UMCProductExtras *extras = [[UMCProductExtras alloc] init];
    extras.title = @"活动进行中~~~";
    extras.content = @"¥9999";

    product.extras = @[extras];
    config.product = product;

    UMCSDKStyle *styly = [UMCSDKStyle defaultStyle];
    config.sdkStyle = styly;

    return config;
}
- (void)addCustomButtons {
    //按钮位于输入框上方
    UMCCustomButtonConfig *buttonConfig1 = [[UMCCustomButtonConfig alloc] initWithTitle:@"自定义按钮1" clickBlock:^(UMCCustomButtonConfig *customButton, UMCIMViewController *viewController) {
            //do something
          //UdeskChatViewController 有可以发送消息的方法。
    }];
    buttonConfig1.type = UMCCustomButtonTypeInInputTop;

    //按钮位于更多
    UMCCustomButtonConfig *buttonConfig2 = [[UMCCustomButtonConfig alloc] initWithTitle:@"自定义按钮2" clickBlock:^(UMCCustomButtonConfig *customButton, UMCIMViewController *viewController) {
            //do something
          //UdeskChatViewController 有可以发送消息的方法。
    }];
    buttonConfig2.type = UMCCustomButtonTypeInMoreView;

    UMCSDKConfig *config = [UMCSDKConfig sharedConfig];
    config.showCustomButtons = YES;
    config.customButtons = @[buttonConfig1,buttonConfig2];

    UMCSDKStyle *style = [UMCSDKStyle defaultStyle];
    config.sdkStyle = style;

    //直接进入聊天页面
    UMCSDKManager *sdkManager = [[UMCSDKManager alloc] initWithMerchantEuid:@"merchantEuid"];
    sdkManager.sdkConfig = config;
    [sdkManager pushUdeskInViewController:self completion:nil];
}
- (IBAction)hh_chat:(id)sender {
    HHSnowViewController *vc = [[HHSnowViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *) sha1:(NSString *)input {
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (void)click:(UIButton *)btn {
    CGPoint point           = CGPointMake(self.view.frame.size.width - 40, btn.frame.origin.y + btn.frame.size.width + 35);
    XTPopTableView *popView = [[XTPopTableView alloc] initWithOrigin:point Width:150 Height:30 * 3 Type:XTTypeOfUpRight Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
    popView.dataArray       = @[@"添加朋友", @"扫一扫", @"付款"];
    popView.images          = @[@"添加朋友", @"扫一扫", @"付款"];
    popView.row_height      = 30;
    popView.delegate        = self;
    popView.titleTextColor  = [UIColor colorWithRed:0.2669 green:0.765 blue:1.0 alpha:1.0];
    [popView popView];
}
- (void)btnClick {
    CGPoint point           = self.view.center;
    XTPopNormalView * view  = [[XTPopNormalView alloc] initWithOrigin:point Width:150 Height:150 Type:XTTypeOfDownCenter Color:[UIColor cyanColor]];
    [view.btnDiss setTitle:@"点我 DISSMISS" forState:UIControlStateNormal];
    [view popView];

}
- (void)selectIndexPathRow:(NSInteger )index {
    NSLog(@"Index ======== %ld", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runtime {
    
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    NSLog(@"res1 == %d",res1);
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    NSLog(@"res2 == %d",res2);
//    BOOL res3 = [(id)[Sark class] isKindOfClass:[Sark class]];
//    NSLog(@"res3 == %d",res3);
//    BOOL res4 = [(id)[Sark class] isMemberOfClass:[Sark class]];
//    NSLog(@"res4 == %d",res4);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self runtime];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == _cardTF) {
        NSString *text = [_cardTF text];
        
        

        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }

        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }

        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];

        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }

        [_cardTF setText:newString];

        return NO;

    }
    return YES;
}

// 银行卡号转正常号 － 去除4位间的空格
-(NSString *)bankNumToNormalNum {
    return [_cardTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

