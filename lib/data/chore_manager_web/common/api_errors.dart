import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/common/api_error.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/response_type.dart';
import 'package:chore_manager_mobile/data/concerns/jsonable.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

class ApiErrors extends ApiResponse with Jsonable {
  late final int statusCode;
  late final String message;
  late final List<ApiError>? errors;

  ApiErrors({
    required this.message,
    required this.errors,
    required this.statusCode,
  }) : super(ResponseType.failure);

  ApiErrors.fromHttpResponse(http.Response response)
      : super.fromHttpResponse(response) {
    statusCode = response.statusCode;
    final json = jsonDecode(response.body);
    message = json['message'];
    errors = _parseErrors(json);
  }

  List<ApiError>? _parseErrors(json) {
    if (json['errors'] == null) return null;

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
      errors?.any((error) => error.field == field) ?? false;

  List<String> getErrorsForField(String field) =>
      errors?.firstWhere((error) => error.field == field).messages ?? [];

  @override
  String toString() {
    return '''
    Message: $message
    Errors : $errors
    ''';
  }

  @override
  Map<String, dynamic> toJson() => {
        'message': message,
        if (errors != null) 'errors': _errorsToJson(),
      };

  Map<String, dynamic> _errorsToJson() {
    return {for (final ApiError e in errors!) e.field: e.messages};
  }

  bool get isAuthError => statusCode == HttpStatus.unauthorized;

  bool get isServerError => statusCode == HttpStatus.internalServerError;
}
