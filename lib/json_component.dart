import 'package:flutter/widgets.dart';
import 'package:json_component/common/extensions/null_extension.dart';
import 'package:json_component/common/types/component_exception.dart';
import 'package:json_component/common/types/component_type.dart';
import 'package:json_component/component_builder.dart';

class JsonComponent {
  final Map<String, ComponentBuilder> _registeredJson = {};
  final Map<String, void Function(ComponentState)> _registeredState = {};

  static late JsonComponent _instance;

  JsonComponent._();

  static void initialize() {
    _instance = JsonComponent._();
  }

  static JsonComponent get instance => _instance;

  factory JsonComponent() => instance;

  void register(String id, ComponentBuilder builder) {
    if (containsId(id)) {
      throw ComponentRegisteredException(id);
    }

    _registeredJson[id] = builder;
  }

  bool containsId(String id) {
    return _registeredJson.containsKey(id);
  }

  void setState(String key, ComponentState state) {
    _registeredState[key].let(
      (callback) => callback.call(state),
    );
  }

  Widget build(
    BuildContext context,
    ComponentJson json, [
    ComponentContext cContext = const {},
  ]) {
    final componentId = json['_id'];

    if (componentId == null) {
      throw ComponentInvalidException(json);
    }

    final builder = _registeredJson[componentId];

    if (builder == null) {
      throw ComponentNotFoundException(componentId);
    }

    final component = builder(json);

    return ComponentBuilderWidget(
      context: cContext,
      component: component,
      setState: (callback) => component.key.let(
        (key) => _registeredState[key] = callback,
      ),
      onDispose: () => component.key.let(
        _registeredState.remove,
      ),
    );
  }
}
