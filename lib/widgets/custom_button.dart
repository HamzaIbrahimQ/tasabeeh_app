import 'package:flutter/material.dart';
import 'package:new_tasabeeh_app/constants/constants.dart';




Widget customButton(String arText, String enText, String selectedLanguage, double size, Function onPressed) {
  return TextButton(
    child: Text(
      selectedLanguage == languages[0] ? arText : enText,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: prColor,
        fontSize: size * 0.7,
      ),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(scColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    onPressed: onPressed,
  );
}