import 'dart:convert';

mixin Jsonable {
  Map<String, dynamic> toJson();

  String toJsonString() => jsonEncode(toJson());
}
