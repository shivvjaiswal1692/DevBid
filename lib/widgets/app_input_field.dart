import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }
}
