import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Color? textColor;
  final String? Function(String?)? validator;
  final GestureTapCallback? onTap;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      this.obscureText = false,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.textColor,
      this.onSuffixTap,
      this.validator,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.name,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Color(0xffEDEDED),
        filled: true,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.black) : null,
        prefixIconColor: Colors.black,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(suffixIcon),
              )
            : null,
        suffixIconColor: Colors.black,
        hintText: hintText,
        hintStyle: TextStyle(
          color: textColor,
          fontSize: 14,
          fontFamily: 'Poppins1',
          letterSpacing: 1.12,
        ),
        border: OutlineInputBorder(),
        // ##### focusedBorder #####
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD0D0D0)),
            borderRadius: BorderRadius.circular(10)),

        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD0D0D0)),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
