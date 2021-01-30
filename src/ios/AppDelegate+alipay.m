#import "AppDelegate+Alipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (alipay)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            CDVPluginResult *pluginResult;
            
            if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
                NSLog(@"alipay success");
            } else {
                NSLog(@"alipay error");
            }
        }];
    }
}

@end