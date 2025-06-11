import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'Poppins1',
        color: Color(0xff222222),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffEDEDED),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff999999),
          fontSize: 14,
          fontFamily: 'Poppins1',
          letterSpacing: 1.12,
        ),
        suffixIcon: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Color(0xff999999)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffD0D0D0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffD0D0D0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffD0D0D0)),
        ),
      ),
      icon: const SizedBox(), // Removes default dropdown icon
      dropdownColor: Colors.white,
    );
  }
}
