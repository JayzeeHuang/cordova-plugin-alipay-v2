#import "AppDelegate+Alipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (alipay)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
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
