import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required String hintText,
  required IconData icon,
  Color borderColor = Colors.grey,
  Color hintTextColor = Colors.black54,
  Color fillColor = Colors.white,
  bool obscureText = false,
  TextInputType type = TextInputType.text,
  required TextEditingController controller,
  required final FormFieldValidator fieldValidator,
  required final FormFieldValidator fieldOnChange,
}) =>
    TextFormField(
      onChanged: fieldOnChange,
      validator: fieldValidator,
      obscureText: obscureText,
      keyboardType: type,
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
        prefixIcon: Icon(
          icon,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
