#ifndef FLUTTER_PLUGIN_JSON_COMPONENT_PLUGIN_H_
#define FLUTTER_PLUGIN_JSON_COMPONENT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace json_component {

class JsonComponentPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  JsonComponentPlugin();

  virtual ~JsonComponentPlugin();

  // Disallow copy and assign.
  JsonComponentPlugin(const JsonComponentPlugin&) = delete;
  JsonComponentPlugin& operator=(const JsonComponentPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace json_component

#endif  // FLUTTER_PLUGIN_JSON_COMPONENT_PLUGIN_H_
