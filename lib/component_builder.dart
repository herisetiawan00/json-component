import 'package:flutter/widgets.dart';
import 'package:json_component/common/extensions/null_extension.dart';
import 'package:json_component/common/types/component_type.dart';
import 'package:json_component/components/base_json_component.dart';

class ComponentBuilderWidget extends StatefulWidget {
  final ComponentContext context;
  final BaseJsonComponent component;
  final void Function(void Function(ComponentState))? setState;
  final VoidCallback? onDispose;

  const ComponentBuilderWidget({
    super.key,
    required this.context,
    required this.component,
    required this.setState,
    this.onDispose,
  });

  @override
  State<ComponentBuilderWidget> createState() => _ComponentBuilderWidgetState();
}

class _ComponentBuilderWidgetState extends State<ComponentBuilderWidget> {
  ValueNotifier<ComponentState>? _stateNotifier;

  @override
  void initState() {
    super.initState();
    widget.component.initState();

    widget.component.state.let(
      (state) => _stateNotifier = ValueNotifier(state),
    );

    widget.setState.let(
      (fn) => fn.call(_updateState),
    );
  }

  @override
  void dispose() {
    _stateNotifier?.dispose();
    widget.onDispose?.call();
    super.dispose();
  }

  void _updateState(ComponentState state) {
    _stateNotifier?.value = {..._stateNotifier!.value, ...state};
  }

  @override
  Widget build(BuildContext context) {
    return _stateNotifier.let(
          (notifier) => ValueListenableBuilder<ComponentState>(
            valueListenable: notifier,
            builder: (context, state, _) => widget.component.build(
              context,
              {...widget.context, 'state': state},
            ),
          ),
        ) ??
        widget.component.build(context, widget.context);
  }
}
