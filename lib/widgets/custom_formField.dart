import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  CustomFormField(
      {required this.controller,
      required this.labelText,
      required this.hintText,
      required this.keyboardType,
      required this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        maxLines: 1,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.pinkAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
