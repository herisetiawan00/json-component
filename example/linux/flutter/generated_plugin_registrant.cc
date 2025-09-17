//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <json_component/json_component_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) json_component_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "JsonComponentPlugin");
  json_component_plugin_register_with_registrar(json_component_registrar);
}
