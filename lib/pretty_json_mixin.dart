library pretty_json_mixin;

import 'dart:convert';

mixin PrettyJsonMixin {
  Map<String, dynamic> toJson();

  @override
  String toString() {
    final encoder = JsonEncoder.withIndent(' ' * 2);
    return encoder.convert(toJson());
  }
}
