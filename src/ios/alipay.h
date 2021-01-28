
#import <AlipaySDK/AlipaySDK.h>
#import <Cordova/CDV.h>
#import "AppDelegate.h"

@interface alipay : CDVPlugin

    @property NSString *appId;
    @property NSString *callbackId;

- (void)payment:(CDVInvokedUrlCommand*)command;

@end
