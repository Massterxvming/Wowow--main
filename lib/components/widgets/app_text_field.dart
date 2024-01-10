import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../styles/app_colors.dart';


class AppTextField extends StatelessWidget {
   const AppTextField( {super.key, this.onChanged, required this.hint, required this.labelText, this.keyboardType, this.obscureText=false, this.inputFormatters, this.maxLength});
  final String hint;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.black,
        ),
        border: const OutlineInputBorder(),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.fieldColor,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: AppColors.fieldColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle:  const TextStyle(color: AppColors.floatingLabelTextColor),
        filled: true,
        fillColor: AppColors.fieldColor,
      ),
    );
  }
}