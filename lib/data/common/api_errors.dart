import 'dart:convert';

import 'package:chore_manager_mobile/data/common/api_error.dart';
import 'package:http/http.dart' as http;

class ApiErrors {
  late final String message;
  late final List<ApiError> errors;

  ApiErrors.fromHttpResponse(http.Response response) {
    final json = jsonDecode(response.body);
    message = json['message'];
    errors = _parseErrors(json);
  }

  List<ApiError> _parseErrors(json) {
    return (json['errors'] as Map<String, dynamic>)
        .entries
        .map<ApiError>(
          (e) => ApiError(
            field: e.key,
            messages: List<String>.from(e.value),
          ),
        )
        .toList();
  }

  bool hasErrorForField(String field) =>
      errors.any((error) => error.field == field);

  List<String> getErrorsForField(String field) =>
      errors.firstWhere((error) => error.field == field).messages;

  @override
  String toString() {
    return '''
    Message: $message
    Errors : $errors
    ''';
  }
}
