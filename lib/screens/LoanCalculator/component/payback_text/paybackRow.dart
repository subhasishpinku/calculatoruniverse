import 'package:calculatoruniverse/screens/LoanCalculator/component/compoundDropdownField.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/component/Compound_text/compoundLabel.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/component/payback_text/paybackDropdownField.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/component/payback_text/paybackLabel.dart';
import 'package:flutter/material.dart';

class PayBackRow extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const PayBackRow({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PayBackLabel(),
          Expanded(
            child: PayBackDropdownField(
              controller: controller,
              selectedValue: selectedValue,
              onValueChanged: onValueChanged,
            ),
          ),
        ],
      ),
    );
  }
}
