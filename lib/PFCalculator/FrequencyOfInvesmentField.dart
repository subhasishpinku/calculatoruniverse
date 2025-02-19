import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class FrequencyOfInvesmentField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const FrequencyOfInvesmentField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _FrequencyOfInvesmentFieldState createState() =>
      _FrequencyOfInvesmentFieldState();
}

class _FrequencyOfInvesmentFieldState extends State<FrequencyOfInvesmentField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 18),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Frequency of Investment',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColor.lightGrayColor,
                width: 1.0,
              ),
            ),
            suffixIcon: DropdownButton<String>(
              value: widget.selectedValue,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem(
                  value: 'Monthly',
                  child: Text('Monthly'),
                ),
                DropdownMenuItem(
                  value: 'Quarterly',
                  child: Text('Quarterly'),
                ),
                DropdownMenuItem(
                  value: 'Half Yearly',
                  child: Text('Half Yearly'),
                ),
                DropdownMenuItem(
                  value: 'Yearly',
                  child: Text('Yearly'),
                ),
              ],
              onChanged: (value) {
                widget.onValueChanged(value);
              },
            ),
          ),
          readOnly: true,
        ));
  }
}
