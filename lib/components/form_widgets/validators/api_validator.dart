import 'package:chore_manager_mobile/components/form_widgets/validators/validator.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';

class ApiValidator extends Validator {
  ApiErrors? Function() errors;
  String field;

  ApiValidator({required this.field, required this.errors}) : super();

  @override
  bool isValid(String? value) =>
      errors() == null || !errors()!.hasErrorForField(field);

  @override
  String get failMessage => errors()?.getErrorsForField(field).first ?? '';
}
