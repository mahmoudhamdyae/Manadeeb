import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color, TextDecoration decoration) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration
  );
}

TextStyle getLargeStyle(
    {double fontSize = FontSize.s16, FontWeight fontWeight = FontWeightManager.bold, Color color = ColorManager.black, TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(fontSize, fontWeight, color, decoration);
}

TextStyle getSmallStyle(
    {double fontSize = FontSize.s14, FontWeight fontWeight = FontWeightManager.regular, Color color = ColorManager.black, TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(fontSize, fontWeight, color, decoration);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color, TextDecoration.none);
}

ButtonStyle getFilledButtonStyle({Color color = ColorManager.primary}) {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        )
    ),
    backgroundColor: MaterialStateProperty.all(color),
  );
}

ButtonStyle getOutlinedButtonStyle({Color color = ColorManager.primary}) {
  return OutlinedButton.styleFrom(
    side: BorderSide(
      width: 1.0,
      color: color,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

InputDecoration getTextFieldDecoration({
  required String hint,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  required Function onPressed
}) {
  return InputDecoration(
    prefixIconConstraints: BoxConstraints(
      maxWidth: prefixIcon == null ? 16.0 : 32.0,
      minWidth: prefixIcon == null ? 16.0 : 32.0,
    ),
    prefixIcon: Icon(prefixIcon, color: const Color(0xff545454), size: 17,),
    suffixIcon: IconButton(
      icon: Icon(
        suffixIcon,
        color: const Color(0xff545454),
        size: 17,
      ),
      onPressed: () {
        onPressed();
      },
    ),
    hintText: hint,
    border: const OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: ColorManager.lightGrey),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
  );
}