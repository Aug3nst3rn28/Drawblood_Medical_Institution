import 'package:drawblood_medicalinstitution_app/drawblood_app/components/text_field_container.dart';
import 'package:flutter/material.dart';

class EditInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const EditInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
