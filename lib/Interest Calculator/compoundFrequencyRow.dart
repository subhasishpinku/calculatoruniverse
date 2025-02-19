import 'package:calculatoruniverse/Interest%20Calculator/PeriodUnitCompoundField.dart';
import 'package:calculatoruniverse/Interest%20Calculator/compoundFrequencyField.dart';
import 'package:calculatoruniverse/InterestCalculator/Interest_text/InterestLabel.dart';
import 'package:calculatoruniverse/InterestCalculator/component/InterestDropdownCompoundField.dart';
import 'package:flutter/material.dart';

class compoundFrequencyRow extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const compoundFrequencyRow({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 16, top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const InterestLabel(),
          Expanded(
            child: CompoundFrequencyField(
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
