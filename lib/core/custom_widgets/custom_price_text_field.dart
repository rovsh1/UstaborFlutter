import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

import 'custom_text_field/price_text_input_formatter.dart';

class CustomPriceTextField extends StatelessWidget {
  final String? labelText;
  final bool? showError;
  final int maxLines;
  final TextEditingController? controller;
  final bool autoFocus;
  final Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? errorText;
  final TextInputAction? inputAction;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final String? hintText;
  final BuildContext? context;
  final Function()? onTap;
  final bool readOnly;
  final double labelPadding;

  CustomPriceTextField({
    Key? key,
    this.labelText,
    this.showError,
    this.controller,
    this.autoFocus = false,
    this.onChanged,
    this.keyboardType,
    this.prefixText,
    this.errorText,
    this.inputAction,
    this.currentFocus,
    this.nextFocus,
    this.hintText,
    this.context,
    this.onTap,
    this.labelPadding = 4,
    this.maxLines = 1,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16),
        Text(
          labelText ?? '',
          style: AppStyle.baseStyle.copyWith(
            fontSize: 12,
          ),
        ),
        SizedBox(height: labelPadding),
        TextFormField(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
            fontFamily: 'SfPro',
          ),
          readOnly: readOnly,
          controller: controller,
          focusNode: currentFocus,
          onTap: onTap,
          expands: false,
          maxLines: maxLines,
          minLines: 1,
          autofocus: autoFocus,
          inputFormatters: [PriceTextInputFormatter(), LengthLimitingTextInputFormatter(15),],
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
          onFieldSubmitted: (term) => fieldFocusChange(
            context,
            currentFocus,
            nextFocus,
          ),
          textInputAction: inputAction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            filled: true,
            hintText: hintText,
            fillColor: AppColor.white,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff4A4A4A).withOpacity(.5),
              fontFamily: 'SFPro',
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.grey30, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.grey30,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            errorText: showError ?? false ? errorText : null,
          ),
          cursorColor: AppColor.grey30,
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  fieldFocusChange(
    BuildContext context,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
  ) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
