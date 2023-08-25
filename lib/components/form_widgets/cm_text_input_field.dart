import 'package:flutter/material.dart';

class CMTextInputField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final Iterable<String>? autofillHints;

  const CMTextInputField({
    this.onChanged,
    this.validator,
    this.labelText,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.autofillHints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
      ),
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      validator: validator,
      autofillHints: autofillHints,
    );
}
