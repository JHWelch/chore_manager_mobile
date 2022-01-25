import 'dart:convert';
import 'package:chore_manager_mobile/extensions/date_time_formatting.dart';

mixin Jsonable {
  Map<String, dynamic> toJson();

  String toJsonString() => jsonEncode(toJson(), toEncodable: encodeSpecial);

  dynamic encodeSpecial(dynamic item) {
    if (item is DateTime) {
      return item.toFullIso8601String();
    }
    return item;
  }
}
