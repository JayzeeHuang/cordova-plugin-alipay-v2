/********* alipay.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <AlipaySDK/AlipaySDK.h>

@interface alipay : CDVPlugin
@property(nonatomic,strong)NSString *app_id;
@property(nonatomic,strong)NSString *currentCallbackId;

- (void)payment:(CDVInvokedUrlCommand*)command;
@end

@implementation alipay

#pragma mark "API"
- (void)pluginInitialize {
    CDVViewController *viewController = (CDVViewController *)self.viewController;
    self.app_id = [viewController.settings objectForKey:@"alipayid"];
}

- (void)payment:(CDVInvokedUrlCommand*)command
{
    self.currentCallbackId = command.callbackId;
    NSString* orderString = [command.arguments objectAtIndex:0];
    NSString* appScheme = [NSString stringWithFormat:@"a%@", self.app_id];
    
    if (orderString != nil) {
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
                [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
            } else {
                [self failWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
            }
            
            NSLog(@"reslut = %@",resultDic);
        }];

    }
}

- (void)handleOpenURL:(NSNotification *)notification 
{
    NSURL* url = [notification object];
    
    if ([url isKindOfClass:[NSURL class]] && [url.scheme isEqualToString:[NSString stringWithFormat:@"a%@", self.app_id]])
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
                [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
            } else {
                [self failWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
            }
        }];
    }
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}
- (void)successWithCallbackID:(NSString *)callbackID messageAsDictionary:(NSDictionary *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID messageAsDictionary:(NSDictionary *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    if (!url) {
        return NO;
    }
    NSMutableDictionary * openURLData = [[NSMutableDictionary alloc] init];
    [openURLData setValue:url forKey:@"url"];
    if (options[UIApplicationOpenURLOptionsSourceApplicationKey]) {
        [openURLData setValue:options[UIApplicationOpenURLOptionsSourceApplicationKey] forKey:@"sourceApplication"];
    }
    if (options[UIApplicationOpenURLOptionsAnnotationKey]) {
        [openURLData setValue:options[UIApplicationOpenURLOptionsAnnotationKey] forKey:@"annotation"];
    }
    // all plugins will get the notification, and their handlers will be called
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLWithAppSourceAndAnnotationNotification object:openURLData]];
    return YES;
}

@end
