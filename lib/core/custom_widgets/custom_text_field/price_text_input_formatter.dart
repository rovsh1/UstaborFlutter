
import 'package:flutter/services.dart';

class PriceTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      //String.fromCharCodes(input.runes.toList().reversed
      String reversedText = String.fromCharCodes(newValue.text.runes.toList().reversed);
      List<String> chars = reversedText.replaceAll(' ', '').split('');
      String reversedNewString = '';
      for (int i = 0; i < chars.length; i++) {
        if (i % 3 == 0 && i != 0) reversedNewString += ' ';
        reversedNewString += chars[i];
      }
      String newString = String.fromCharCodes(reversedNewString.runes.toList().reversed);

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}