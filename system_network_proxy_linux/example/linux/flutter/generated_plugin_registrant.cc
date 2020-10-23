//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <system_network_proxy_linux/system_network_proxy_linux_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) system_network_proxy_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SystemNetworkProxyLinuxPlugin");
  system_network_proxy_linux_plugin_register_with_registrar(system_network_proxy_linux_registrar);
}
