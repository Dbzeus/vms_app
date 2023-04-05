import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vms_app/helper/colors.dart';

class BoxEditText extends StatelessWidget {
  String placeholder;
  Widget? suffixIcon;
  Widget? prefixIcon;
  EdgeInsets? contentPadding;
  int? maxLines, maxLength;
  bool? squareInput, readOnly, obsecureText;
  TextEditingController controller;
  Color? fillColor;
  Function()? onTab;
  Function(String)? onChanged, onSubmitted, validator;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  double? width;
  bool isOnlyInt;
  TextCapitalization? caps;

  BoxEditText(
      {required this.placeholder,
      required this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.contentPadding,
      this.maxLines,
      this.squareInput = true,
      this.readOnly = false,
      this.obsecureText = false,
      this.isOnlyInt = false,
      this.fillColor,
      this.caps,
      this.onTab,
      this.onChanged,
      this.keyboardType,
      this.maxLength,
      this.textInputAction,
      this.onSubmitted,
      this.validator,
      this.width});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: fillColor ?? Colors.white,
          boxShadow: const [BoxShadow(color: stroke, blurRadius: 0.5)]),
      child: TextFormField(
          onTap: onTab,
          controller: controller,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType,
          obscureText: obsecureText ?? false,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          inputFormatters: isOnlyInt
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          textCapitalization: caps ?? TextCapitalization.none,
          onFieldSubmitted: onSubmitted,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            filled: false,
            counterText: '',
            counter: null,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.all(12),
          )),
    );
  }
}
