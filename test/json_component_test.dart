import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_component/common/extensions/string_extension.dart';
import 'package:json_component/common/types/component_exception.dart';
import 'package:json_component/common/types/component_type.dart';
import 'package:json_component/components/base_json_component.dart';
import 'package:json_component/json_component.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

class TestComponent extends BaseJsonComponent {
  TestComponent.fromJson(super.json) : super.fromJson();

  @override
  Widget build(BuildContext context, ComponentContext cContext) => Text(id);
}

class TestComponentWithState extends BaseJsonComponent {
  final String data;
  TestComponentWithState.fromJson(super.json)
      : data = json['data'],
        super.fromJson();

  @override
  Widget build(BuildContext context, ComponentContext cContext) =>
      Text(data.withContext(cContext));
}

void main() {
  group('JsonComponent', () {
    const String componentId = 'testComponentId';

    setUpAll(JsonComponent.initialize);

    tearDown(JsonComponent.clear);

    test('should be able to register new component', () {
      expect(JsonComponent.containsId(componentId), isFalse);

      JsonComponent.register(componentId, TestComponent.fromJson);

      expect(JsonComponent.containsId(componentId), isTrue);
    });

    test(
        'should throw [ComponentRegisteredException] error '
        'when component registered multiple time', () {
      JsonComponent.register(componentId, TestComponent.fromJson);

      expect(JsonComponent.containsId(componentId), isTrue);

      expect(
        () => JsonComponent.register(componentId, TestComponent.fromJson),
        throwsA(isA<ComponentRegisteredException>()),
      );
    });

    testWidgets('should be able to build component when component registered',
        (tester) async {
      final ComponentJson component = {
        '_id': componentId,
      };

      JsonComponent.register(componentId, TestComponent.fromJson);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => JsonComponent.build(context, component),
          ),
        ),
      );

      expect(find.text(componentId), findsOneWidget);
    });

    testWidgets(
        'should be able to build component when component registered '
        'and able to update state', (tester) async {
      const key = 'component-key';
      final ComponentJson component = {
        '_id': componentId,
        '_state': {'data': 'test'},
        '_key': key,
        'data': '\$state.data',
      };

      JsonComponent.register(componentId, TestComponentWithState.fromJson);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => JsonComponent.build(context, component),
          ),
        ),
      );

      expect(find.text('test'), findsOneWidget);

      JsonComponent.setState(key, {'data': 'updated'});

      await tester.pumpAndSettle();

      expect(find.text('updated'), findsOneWidget);
    });

    test(
        'should throw [ComponentInvalidException] error '
        'when component does not have [_id]', () {
      final BuildContext context = MockBuildContext();

      final ComponentJson component = {};

      expect(
        () => JsonComponent.build(context, component),
        throwsA(isA<ComponentInvalidException>()),
      );
    });

    test(
        'should throw [ComponentNotFoundException] error '
        'when component not registered', () {
      final BuildContext context = MockBuildContext();

      final ComponentJson component = {'_id': 'test'};

      expect(
        () => JsonComponent.build(context, component),
        throwsA(isA<ComponentNotFoundException>()),
      );
    });

    test(
        'should throw [ComponentNotFoundException] error '
        'when component not registered', () {
      final BuildContext context = MockBuildContext();

      final ComponentJson component = {'_id': componentId};

      JsonComponent.register(componentId, TestComponentWithState.fromJson);

      expect(
        () => JsonComponent.build(context, component),
        throwsA(isA<ComponentParsingException>()),
      );
    });
  });
}
