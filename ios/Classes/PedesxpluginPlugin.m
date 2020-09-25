#import "PedesxpluginPlugin.h"
#if __has_include(<pedesxplugin/pedesxplugin-Swift.h>)
#import <pedesxplugin/pedesxplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pedesxplugin-Swift.h"
#endif

@implementation PedesxpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPedesxpluginPlugin registerWithRegistrar:registrar];
}
@end
