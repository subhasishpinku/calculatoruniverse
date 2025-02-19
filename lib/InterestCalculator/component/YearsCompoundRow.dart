import 'package:calculatoruniverse/InterestCalculator/Interest_text/InterestLabel.dart';
import 'package:calculatoruniverse/InterestCalculator/Interest_text/YearsLabel.dart';
import 'package:calculatoruniverse/InterestCalculator/component/InterestDropdownCompoundField.dart';
import 'package:calculatoruniverse/InterestCalculator/component/YearsDropdownCompoundField.dart';
import 'package:flutter/material.dart';

class YearsCompoundRow extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const YearsCompoundRow({
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
          const YearsLabel(),
          Expanded(
            child: YearsDropdownCompoundField(
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
