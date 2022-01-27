## Motivation
The `toString()` method is useful for a logging but its default implementation doesn't generate a readable string. But overriding every single class's `toString()` method is tedious doesn't scale well. `PrettyJsonMixin` overrides the `toString()` method and return a pretty json formatted string.

## Getting started
Implement the `toJson()` method, then the `toString()` will automatically produce a pretty json string.
``` dart
class User with PrettyJsonMixin {
  User({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

void main() {
  final user = User(
    id: '1',
    name: 'Hello World!',
  );
  print(user.toString());
  // Prints
  // {
  // "id": "1",
  // "name": "Hello World!"
  // }
}
```
You wouldn't want to implement the `toJson()` method by yourself. Use the [json_serializable](https://pub.dev/packages/json_serializable) package and auto-generate the `toJson()` method.
``` dart
@JsonSerializable()
class User with PrettyJsonMixin {
  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final String name;
}

void main() {
  final user = User(
    id: '1',
    name: 'Hello World!',
  );
  print(user.toString());
  // Prints
  // {
  // "id": "1",
  // "name": "Hello World!"
  // }
}
```

## Additional information
The implementation for the `PrettyJsonMixin` is nothing more than the below. If you don't want to add an extra external dependency, then just feel free to copy and paste the below code.
``` dart
mixin PrettyJsonMixin {
  Map<String, dynamic> toJson();

  @override
  String toString() {
    final encoder = JsonEncoder.withIndent(' ' * 2);
    return encoder.convert(toJson());
  }
}
```
