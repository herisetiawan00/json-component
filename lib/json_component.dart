import 'package:flutter/widgets.dart';
import 'package:json_component/common/extensions/null_extension.dart';
import 'package:json_component/common/types/component_exception.dart';
import 'package:json_component/common/types/component_type.dart';
import 'package:json_component/component_builder.dart';
import 'package:json_component/components/base_json_component.dart';

export 'package:json_component/common/extensions/string_extension.dart';
export 'package:json_component/common/types/component_exception.dart';
export 'package:json_component/common/types/component_type.dart';
export 'package:json_component/components/base_json_component.dart';


class JsonComponent {
  final Map<String, ComponentBuilder> _registeredJson = {};
  final Map<String, void Function(ComponentState)> _registeredState = {};

  static late JsonComponent _instance;

  JsonComponent._();

  static void initialize() {
    _instance = JsonComponent._();
  }

  static JsonComponent get instance => _instance;

  static void register(String id, ComponentBuilder builder) {
    if (containsId(id)) {
      throw ComponentRegisteredException(id, StackTrace.current);
    }

    instance._registeredJson[id] = builder;
  }

  static bool containsId(String id) {
    return instance._registeredJson.containsKey(id);
  }

  static void setState(String key, ComponentState state) {
    instance._registeredState[key].let(
      (callback) => callback.call(state),
    );
  }

  static void clear() {
    instance._registeredJson.clear();
    instance._registeredState.clear();
  }

  static Widget build(
    BuildContext context,
    ComponentJson json, [
    ComponentContext cContext = const {},
  ]) {
    final componentId = json['_id'];

    if (componentId == null) {
      throw ComponentInvalidException(json, StackTrace.current);
    }

    final builder = instance._registeredJson[componentId];

    if (builder == null) {
      throw ComponentNotFoundException(componentId, StackTrace.current);
    }

    BaseJsonComponent component;
    try {
      component = builder(json);
    } catch (e, stackTrace) {
      throw ComponentParsingException(json, stackTrace);
    }

    return ComponentBuilderWidget(
      context: cContext,
      component: component,
      setState: (callback) => component.key.let(
        (key) => instance._registeredState[key] = callback,
      ),
      onDispose: () => component.key.let(
        instance._registeredState.remove,
      ),
    );
  }
}
