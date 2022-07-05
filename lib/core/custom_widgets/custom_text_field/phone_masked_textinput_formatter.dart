import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneMaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  PhoneMaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.contains(".")){
      return oldValue;
    }
    String text = newValue.text;
    String newText = newValue.toJSON()['text'].toString();
    if (text.length > 0) {
      if (text.length > oldValue.text.length) {
        if (text.length > mask.length) return oldValue;
        if (text.length < mask.length && mask[text.length - 1] == separator) {
          return TextEditingValue(
            text:
            '${oldValue.text}$separator${text.substring(text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      } else {
        if (newText.substring(newText.length - 1) == separator) {
          return TextEditingValue(
            text: newValue.text.substring(0, newValue.text.length - 1),
            selection: TextSelection.collapsed(
              offset: newValue.selection.end - 1,
            ),
          );
        }
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: newValue.selection.end,
        ),
      );
    }
    return newValue;
  }
}