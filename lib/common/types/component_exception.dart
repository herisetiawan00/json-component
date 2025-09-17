import 'package:json_component/common/types/component_type.dart';

abstract class ComponentException implements Exception {
  final String message;
  final StackTrace stackTrace;

  ComponentException(this.message, this.stackTrace);

  @override
  String toString() => '$runtimeType: $message';
}

class ComponentRegisteredException extends ComponentException {
  ComponentRegisteredException(String id, StackTrace stackTrace)
      : super('component $id already registered', stackTrace);
}

class ComponentNotFoundException extends ComponentException {
  ComponentNotFoundException(String id, StackTrace stackTrace)
      : super('component $id not found', stackTrace);
}

class ComponentInvalidException extends ComponentException {
  final ComponentJson json;
  ComponentInvalidException(this.json, StackTrace stackTrace)
      : super('component invalid', stackTrace);
}

class ComponentParsingException extends ComponentException {
  final ComponentJson json;
  ComponentParsingException(this.json, StackTrace stackTrace)
      : super('component parsing failed', stackTrace);
}
