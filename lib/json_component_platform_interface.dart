import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'json_component_method_channel.dart';

abstract class JsonComponentPlatform extends PlatformInterface {
  /// Constructs a JsonComponentPlatform.
  JsonComponentPlatform() : super(token: _token);

  static final Object _token = Object();

  static JsonComponentPlatform _instance = MethodChannelJsonComponent();

  /// The default instance of [JsonComponentPlatform] to use.
  ///
  /// Defaults to [MethodChannelJsonComponent].
  static JsonComponentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JsonComponentPlatform] when
  /// they register themselves.
  static set instance(JsonComponentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
