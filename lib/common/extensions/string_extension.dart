import 'package:json_component/common/types/component_type.dart';

extension StringExtension on String {
  String withContext(
    ComponentContext cContext, {
    List args = const [],
  }) {
    if (startsWith('\$')) {
      final paths = substring(1).split('.');

      dynamic position = {...cContext};
      for (final path in paths) {
        position = position[path];

        if (position == null) {
          return this;
        }
      }

      for (final arg in args) {
        position = '$position'.replaceFirst('%s', '$arg');
      }

      return '$position';
    }

    return this;
  }
}
