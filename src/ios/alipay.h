
#import <AlipaySDK/AlipaySDK.h>
#import <Cordova/CDV.h>
#import "AppDelegate.h"

@interface alipay : CDVPlugin

    @property (copy)NSString *appId;
    @property (copy)NSString *callbackId;

- (void)payment:(CDVInvokedUrlCommand*)command;

@end
