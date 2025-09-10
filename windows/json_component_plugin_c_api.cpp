#include "include/json_component/json_component_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "json_component_plugin.h"

void JsonComponentPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  json_component::JsonComponentPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
