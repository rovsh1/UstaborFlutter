import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field/phone_masked_textinput_formatter.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final bool? showError;
  final int maxLines;
  final int minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool autoFocus;
  final bool isPhone;
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

  CustomTextField({
    Key? key,
    this.labelText,
    this.showError,
    this.controller,
    this.autoFocus = false,
    this.isPhone = false,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.prefixText,
    this.errorText,
    this.inputAction,
    this.currentFocus,
    this.nextFocus,
    this.hintText,
    this.context,
    this.onTap,
    this.labelPadding = 8,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maskedTextInputFormatter = PhoneMaskedTextInputFormatter(mask: '##-###-##-##', separator: '-');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(visible: (labelText??"").isNotEmpty, child: SizedBox(height: 16)),
        Visibility(
          visible:  (labelText??"").isNotEmpty,
          child: Text(
            labelText!,
            style: AppStyle.baseStyle.copyWith(fontSize: 12, color: AppColor.black40),
          ),
        ),
        SizedBox(height: labelPadding),
        TextFormField(
          style: AppStyle.baseStyle.copyWith(
            fontSize: 14,
            color: AppColor.black40,
          ),
          readOnly: readOnly,
          controller: controller,
          focusNode: currentFocus,
          onTap: onTap,
          expands: false,
          maxLines: maxLines,
          minLines: minLines,
          autofocus: autoFocus,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
          onFieldSubmitted: (term) => fieldFocusChange(
            context,
            currentFocus,
            nextFocus,
          ),
          inputFormatters: isPhone ? [maskedTextInputFormatter] : inputFormatters,
          textInputAction: inputAction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            filled: true,
            hintText: hintText,
            hintMaxLines: 1,
            prefixIcon: prefixText != null
                ? Row(
              mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    SvgPicture.asset(
                      "assets/svg/uzbekistan.svg",
                      height: 24,
                      width: 24,
                    ),
                    Container(
                        width: 40,
                        margin: EdgeInsets.only(left: 16, bottom: 2),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "+998",
                              style: AppStyle.baseStyle.copyWith(
                                color: AppColor.black40,
                                fontSize: 14,
                              ),
                            ))),
                  ],
                )
                : null,
            prefixStyle: AppStyle.baseStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
            fillColor: AppColor.white,
            hintStyle: AppStyle.baseStyle.copyWith(
              fontSize: 15,
              color: AppColor.black40.withOpacity(.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.grey30, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.grey30,
                width: 1,
              ),
              borderRadius:  BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red, width: 1),
              borderRadius:  BorderRadius.all(Radius.circular(8)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorStyle: AppStyle.baseStyle.copyWith(
              color: AppColor.red,
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
