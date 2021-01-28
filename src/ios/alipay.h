#import <Cordova/CDV.h>
#import "AppDelegate.h"

@interface alipay : CDVPlugin

    @property (nonatomic, copy) NSString *appId;
    @property (nonatomic, copy) NSString *callbackId;

- (void)payment:(CDVInvokedUrlCommand*)command;

@end
