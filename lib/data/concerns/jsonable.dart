import 'dart:convert';
import 'package:chore_manager_mobile/extensions/date_time_ext.dart';

mixin Jsonable {
  Map<String, dynamic> toJson();

  String toJsonString() => jsonEncode(toJson(), toEncodable: encodeSpecial);

  dynamic encodeSpecial(dynamic item) =>
      item is DateTime ? item.toFullIso8601String() : item;
}
