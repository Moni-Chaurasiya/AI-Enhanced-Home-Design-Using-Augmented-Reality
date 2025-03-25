//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField ({
  required String hintText,
  required IconData icon,
  Color color=Colors.white,
  Color hintTextcolor=Colors.white,
  bool   obscureText= false,
  TextInputType Type =TextInputType.text,

  required TextEditingController controller,
  required final FormFieldValidator fieldValidator,
  required final   FormFieldValidator  fieldonChange,

})=> TextFormField(
  onChanged: fieldonChange,
  validator: fieldValidator,
  obscureText:obscureText ,
  keyboardType:Type ,
  controller: controller ,
  style: TextStyle(color: hintTextcolor),
  decoration: InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: hintTextcolor),
    prefixIcon: Icon(
      icon,
      color: color,

    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white  ),
    ),




  ),
);