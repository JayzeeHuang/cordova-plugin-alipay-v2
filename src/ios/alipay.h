#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>
#import <AlipaySDK/AlipaySDK.h>
#import "APAppDelegate.h"

@interface alipay : CDVPlugin

    @property (nonatomic, copy) NSString *appId;
    @property (nonatomic, copy) NSString *callbackId;

- (void)payment:(CDVInvokedUrlCommand*)command;

@end
