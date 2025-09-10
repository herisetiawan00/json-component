import 'package:flutter_test/flutter_test.dart';
import 'package:json_component/json_component.dart';
import 'package:json_component/json_component_platform_interface.dart';
import 'package:json_component/json_component_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJsonComponentPlatform
    with MockPlatformInterfaceMixin
    implements JsonComponentPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final JsonComponentPlatform initialPlatform = JsonComponentPlatform.instance;

  test('$MethodChannelJsonComponent is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJsonComponent>());
  });

  test('getPlatformVersion', () async {
    JsonComponent jsonComponentPlugin = JsonComponent();
    MockJsonComponentPlatform fakePlatform = MockJsonComponentPlatform();
    JsonComponentPlatform.instance = fakePlatform;

    expect(await jsonComponentPlugin.getPlatformVersion(), '42');
  });
}
