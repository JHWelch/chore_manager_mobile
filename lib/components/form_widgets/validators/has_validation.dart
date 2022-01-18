import 'package:chore_manager_mobile/components/form_widgets/validators/validators.dart';

mixin HasValidation {
  List<Validator> get validators;

  String? validate(String? value) {
    for (final Validator validator in validators) {
      if (!validator.isValid(value)) {
        return validator.failMessage;
      }
    }
    return null;
  }
}
