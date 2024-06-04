import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.textInputAction,
    this.fillColor = Colors.white,
    this.style,
    this.inputFormatters,
    this.hintext,
    this.suffixIcon,
    this.isObsecure = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.height,
    this.borderRadius,
    this.enabled = true,
  }) : super(key: key);

  final String? hintext;
  final IconButton? suffixIcon;
  final bool isObsecure;
  final bool enabled;
  final double? height;
  final BorderRadius? borderRadius;
  final TextEditingController? controller;
  final dynamic validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final dynamic onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 55,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        obscureText: isObsecure,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: style,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          hintText: hintext,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
