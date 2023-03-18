extension StringExt on String {
  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';
}
