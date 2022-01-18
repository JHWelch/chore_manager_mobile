class ApiError {
  final String field;
  final List<String> messages;

  const ApiError({required this.field, required this.messages});

  @override
  String toString() => '$field: $messages';
}
