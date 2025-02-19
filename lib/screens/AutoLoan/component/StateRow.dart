import 'package:calculatoruniverse/screens/AutoLoan/component/autoLoancompoundDropdownField.dart';
import 'package:calculatoruniverse/screens/AutoLoan/component/Compound_text/stateLabel.dart';
import 'package:flutter/material.dart';

class StateRow extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const StateRow({
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
          const StateLabel(),
          Expanded(
            child: AutoLoanCompoundDropdownField(
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
