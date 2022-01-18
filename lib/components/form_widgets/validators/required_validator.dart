import 'package:chore_manager_mobile/components/form_widgets/validators/validators.dart';

class RequiredValidator extends Validator {
  const RequiredValidator() : super();

  @override
  bool isValid(String? value) {
    return value != null && value.isNotEmpty;
  }

  @override
  String get failMessage => 'Required';
}
