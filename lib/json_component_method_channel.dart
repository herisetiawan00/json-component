import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'json_component_platform_interface.dart';

/// An implementation of [JsonComponentPlatform] that uses method channels.
class MethodChannelJsonComponent extends JsonComponentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('json_component');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
