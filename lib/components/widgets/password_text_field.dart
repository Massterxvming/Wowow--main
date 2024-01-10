
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_colors.dart';


class AppPasswordTextField extends StatefulWidget {
  const AppPasswordTextField( {super.key,this.onChanged, required this.hint, required this.labelText, this.keyboardType, this.inputFormatters, this.maxLength});
  final String hint;
  final String labelText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
final int? maxLength;

@override
  State<AppPasswordTextField> createState() => _AppPasswordTextFieldState();
}

class _AppPasswordTextFieldState extends State<AppPasswordTextField> {
  bool obscureText=true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      obscureText: obscureText,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        counterText: '',
        hintText: widget.hint,
        labelText: widget.labelText,
        suffixIcon: IconButton(onPressed: (){
          setState(() {
            obscureText=!obscureText;
          });
        }, icon: Icon(obscureText?Icons.visibility_off:Icons.visibility)),
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
        floatingLabelStyle:   TextStyle(color: AppColors.floatingLabelTextColor),
        filled: true,
        fillColor: AppColors.fieldColor,
      ),
    );
  }
}