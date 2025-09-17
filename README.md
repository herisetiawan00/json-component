# json_component

A json to flutter widget component interpreter

## Getting Started

### Create component
```dart
/// A component that will build a text widget
class TextComponent extends BaseJsonComponent {
    /// Component can have additional field
    final String data;

    /// Need to call super to store common `_id`,`key`, and `_state`
    TextComponent.fromJson(super.json)
        : data = json['data'],
          super.fromJson();

    @override
    Widget build(BuildContext context, ComponentContext: cContext) {
        /// This is how the component will be built on render
        return Text(data);
    }
}
```

### Register component
```dart
/// Component need to be registered to be work, componentId need to be unique per component
JsonComponent.register(componentId, TextComponent.fromJson);
```

### Using component
```dart
class SomeClass extends StatelessWidget {
    ...

    @override
    Widget build(BuildContext context) {
        return ...(
            ...
            /// Need to pass json of the component into `JsonComponent.build`
            child: JsonComponent.build(...)
        )
```


### Component JSON Structure
| Key   | Required | Unique | Description |
|-------|----------|--------|-------------|
| `_id` | Yes      | Yes    | This is the identifier of the component |
| `_state` | Depends | No | Initial state for the component |
| `_key` | Depends | Yes | component identifier for updating state |

### Updating state
```dart
    ...
    /// This state will be concated with previous state
    JsonComponent.setState(key, state);
```

### Using state in component
On the json component we can use state by putting `$state.` on the value, example:
```json
{
    "_id": "text",
    "_key": "title-component-key",
    "_state": {
        "value": "Initial Text",
        "nested": {
            "variable": "sample"
        }
    },
    "data": "$state.value" /// Initial Text
    "otherData": "$state.nested.variable" /// sample
}
```
Then on the component you can use the `data` with `.withContext(...)` to translate the key into real value.

```dart
class TextComponent extends BaseJsonComponent {
    ...

    @override
    Widget build(BuildContext context, ComponentContext: cContext) {
        return Text(data.withContext(cContext)); /// Example of translating pattern to state value
    }
    
    ...
}
```

_*if there is no matched pattern, it will return the key as is_

## Example
- WIP

## Maintainers
- [Heri Setiawan](https://github.com/herisetiawan00)
