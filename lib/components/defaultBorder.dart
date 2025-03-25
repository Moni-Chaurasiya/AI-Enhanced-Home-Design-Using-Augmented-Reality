import 'package:flutter/material.dart';

OutlineInputBorder defaultBorder({ Color c=Colors.white}){

  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((30)),
    borderSide: BorderSide(
      color: c,
      width: 2.0,
    ),
  );
}