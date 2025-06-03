import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String name;
  final double borderRadius;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? inputType;
  final Function? onTap;
  CustomFormField({
    required this.name,
    required this.controller,
    this.borderRadius = 20,
    this.prefixIcon,
    this.inputType,
    this.validator = null,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        onTap!();
      },
      validator: validator,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: name,
        // prefixIcon: prefixIcon,
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(20),
        //     borderSide: BorderSide(
        //       color: Colors.black,
        //     ),
        //     ),
      ),
    );
  }
}

class CustomFilledTextFormField extends StatelessWidget {
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String name;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? inputType;
  CustomFilledTextFormField({
    this.prefixIcon,
    required this.name,
    this.validator,
    required this.controller,
    this.inputType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.blue[50],
        filled: true,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        // focusedBorder: OutlineInputBorder(border),
        hintText: name,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
