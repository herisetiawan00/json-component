import 'package:flutter/widgets.dart';
import 'package:json_component/common/types/component_type.dart';

abstract class BaseJsonComponent {
  final String id;
  final String? key;
  final ComponentState? state;

  BaseJsonComponent.fromJson(ComponentJson json)
      : id = json['_id'],
        key = json['key'],
        state = json['_state'];

  Widget build(BuildContext context, ComponentContext cContext);

  void initState() {}

  void dispose() {}
}
