import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField(
      {super.key,
      required this.hint,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged, this.controller,
       this.obscureText=false
      });
  final String hint;
  final int maxLines;
  final bool obscureText;
     final TextEditingController? controller;

  final void Function(String?)? onSaved;

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      

      obscureText:obscureText,
      onChanged: onChanged,
     controller: controller,
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required ';
        } else {
          return null;
        }
      },
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true, 
        fillColor: Colors.white,
        hintText: hint,
        border: buildBorder(),
        enabledBorder: buildBorder(kPrimaryColor

        ),
        focusedBorder: buildBorder(kPrimaryColor),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(
         20,
        ),
        borderSide: BorderSide(
          color: color ?? Colors.white,
        ));
  }
}