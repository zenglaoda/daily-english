import 'package:flutter/material.dart';

class CusFormItem extends StatelessWidget {
  final Widget child;
  final double top;

  const CusFormItem({
    required this.child,
    super.key,
    this.top = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top),
      child: child,
    );
  }
}


class CusTextFormField extends TextFormField {
  CusTextFormField({
    super.key,
    super.validator,
    super.onChanged,
    String? labelText,
    String? hintText,
    String? errorText,
    int? maxLength,
    bool obscureText = false,
  }):
    super(
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText, 
        hintText: hintText,
        errorText: errorText,

        counterText: '',
        labelStyle: const TextStyle(fontSize: 16),
        floatingLabelStyle: const TextStyle(fontSize: 20),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
      )
    );
}