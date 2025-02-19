import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

RxBool _passwordVisible = false.obs;
Widget createdTextField({
  IconData? prefixIcon,
  Widget? suffixIcon,
  bool? obscureText,
  String? label,
   required String keyonValidate,
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? prefixText,
  validator,
  void Function(String)? onSaved,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      // color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: AppColor.grayColor.withOpacity(0.5), // Bottom border color
          width: 1.0, // Bottom border width
        ),
      ),
    ),
    child: TextFormField(
      validator: validator,
      onSaved: (value) => onSaved?.call(value ?? ""),
      keyboardType: keyboardType,
      obscureText: obscureText! ? !_passwordVisible.value : false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 25,
                color: AppColor.grayColor,
              )
            : null,
        labelText: label,
        labelStyle: TextStyle(
          color: AppColor.defaultBlack.withOpacity(0.8),
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        isDense: true,
        border: InputBorder.none,
      ),
    ),
  );
}
