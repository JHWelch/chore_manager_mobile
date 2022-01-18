abstract class Validator {
  const Validator();

  bool isValid(String? value);
  String get failMessage;
}
