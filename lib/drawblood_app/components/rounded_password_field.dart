import 'package:drawblood_medicalinstitution_app/drawblood_app/components/text_field_container.dart';
import '../drawbood_app_theme.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: drawbloodAppTheme.kPrimaryColor,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: drawbloodAppTheme.kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: drawbloodAppTheme.kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
