
import 'json_component_platform_interface.dart';

class JsonComponent {
  Future<String?> getPlatformVersion() {
    return JsonComponentPlatform.instance.getPlatformVersion();
  }
}
