import 'package:json_component/components/base_json_component.dart';

typedef ComponentJson = Map<String, dynamic>;

typedef ComponentState = Map<String, dynamic>;

typedef ComponentContext = Map<String, Map<String, dynamic>>;

typedef ComponentBuilder = BaseJsonComponent Function(ComponentJson);
