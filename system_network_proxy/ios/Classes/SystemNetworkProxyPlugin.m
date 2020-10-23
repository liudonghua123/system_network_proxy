#import "SystemNetworkProxyPlugin.h"
#if __has_include(<system_network_proxy/system_network_proxy-Swift.h>)
#import <system_network_proxy/system_network_proxy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "system_network_proxy-Swift.h"
#endif

@implementation SystemNetworkProxyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSystemNetworkProxyPlugin registerWithRegistrar:registrar];
}
@end
