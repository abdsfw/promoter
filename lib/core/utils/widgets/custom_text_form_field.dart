import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChange,
    required this.onTap,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final String hintText;
  final void Function(String x)? onChange;
  final Function(String x)? onTap;
  final String? Function(String? x)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 60,
      child: TextFormField(
        // focusNode: FocusScope.of(context).unfocus(),
        controller: controller,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          // focusColor: AppColors.black,
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          // prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ),
        // keyboardType: TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.go,
        onChanged: (value) => onChange!(value),
        onTap: () => onTap!(hintText),
        validator: validator,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
