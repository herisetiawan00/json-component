import 'package:json_component/common/types/component_type.dart';

abstract class ComponentException implements Exception {
  final String message;

  ComponentException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ComponentRegisteredException extends ComponentException {
  ComponentRegisteredException(String id)
      : super('component $id already registered');
}

class ComponentNotFoundException extends ComponentException {
  ComponentNotFoundException(String id) : super('component $id not found');
}

class ComponentInvalidException extends ComponentException {
  final ComponentJson json;
  ComponentInvalidException(this.json) : super('component invalid');
}
